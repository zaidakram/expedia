require 'faraday'
require 'expedia/http_service/response'

module Expedia
  module HTTPService

    API_SERVER = 'api.ean.com'
    RESERVATION_SERVER = 'book.api.ean.com'

    class << self


      # The address of the appropriate Expedia server.
      #
      # @param options various flags to indicate which server to use.
      # @option options :reservation_api use the RESERVATION API instead of the REGULAR API
      # @option options :use_ssl force https, even if not needed
      #
      # @return a complete server address with protocol
      def server(options = {})
        server = "#{options[:reservation_api] ? RESERVATION_SERVER : API_SERVER}"
        "#{options[:use_ssl] ? "https" : "http"}://#{server}"
      end

      # Makes a request directly to Expedia.
      # @note You'll rarely need to call this method directly.
      #
      # @see Expedia::API#api
      #
      # @param path the server path for this request
      # @param args (see Expedia::API#api)
      # @param verb the HTTP method to use.
      # @param options same options passed to server method.
      #
      # @raise an appropriate connection error if unable to make the request to Expedia
      #
      # @return [Expedia::HTTPService::Response] on success. A response object representing the results from Expedia
      # @return [Expedia::APIError] on Error.
      def make_request(path, args, verb, options = {})
        args.merge!(add_common_parameters)
        # figure out our options for this request
        request_options = {:params => (verb == :get ? args : {})}
        # set up our Faraday connection
        conn = Faraday.new(server(options), request_options)
        response = conn.send(verb, path, (verb == :post ? args : {}))

        # Log URL and params information
        Expedia::Utils.debug "\nExpedia [#{verb.upcase}] - #{server(options) + path} params: #{args.inspect} : #{response.status}\n"
        response = Expedia::HTTPService::Response.new(response.status.to_i, response.body, response.headers)

        # If there is an exception make a [Expedia::APIError] object to return
        if response.exception?
          Expedia::APIError.new(response.status, response.body)
        else
          response
        end
      end

      # Encodes a given hash into a query string.
      #
      # @param params_hash a hash of values to CGI-encode and appropriately join
      #
      # @example
      #   Expedia.http_service.encode_params({:a => 2, :b => "My String"})
      #   => "a=2&b=My+String"
      #
      # @return the appropriately-encoded string
      # Method currently not in use.
      def encode_params(param_hash)
        ((param_hash || {}).sort_by{|k, v| k.to_s}.collect do |key_and_value|
           key_and_value[1] = MultiJson.dump(key_and_value[1]) unless key_and_value[1].is_a? String
           "#{key_and_value[0].to_s}=#{CGI.escape key_and_value[1]}"
        end).join("&")
      end


      # Creates a Signature for Expedia using MD5 Checksum Auth.
      # Shared and Api keys are required for Signature along with the current utc time.
      def signature
        if Expedia.cid && Expedia.api_key && Expedia.shared_secret
          Digest::MD5.hexdigest(Expedia.api_key+Expedia.shared_secret+Time.now.utc.to_i.to_s)
        else
          raise Expedia::AuthCredentialsError, "cid, api_key and shared_secret are required for Expedia Authentication."
        end
      end

      # Common Parameters required for every Call to Expedia Server.
      #
      def add_common_parameters
        { :cid => Expedia.cid, :sig => signature, :apiKey => Expedia.api_key, :minorRev => Expedia.minor_rev,
          :_type => 'json', :locale => Expedia.locale, :currencyCode => Expedia.currency_code }
      end

    end

  end
end
