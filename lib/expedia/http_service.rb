require 'faraday'
require 'expedia/http_service/response'

module Expedia
  module HTTPService

    API_SERVER = 'api.eancdn.com'
    DEVELOPMENT_API_SERVER = 'dev.api.ean.com'
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
        if Expedia.cid.to_i == 55505 && !options[:reservation_api]
          server = DEVELOPMENT_API_SERVER
        else
          server = options[:reservation_api] ? RESERVATION_SERVER : API_SERVER
        end
        "#{options[:use_ssl] ? "https" : "http"}://#{server}"
      end


      # Adding open and read timeouts
      #
      # open timeout - the amount of time you are willing to wait for 'opening a connection'
      # (read) timeout - the amount of time you are willing to wait for some data to be received from the connected party.
      # @param conn - Faraday connection object
      #
      # @return the connection obj with the timeouts set if they have been initialized
      def add_timeouts(conn, options)
        if !options[:ignore_timeout]
          conn.options.timeout = Expedia.timeout.to_i if Expedia.timeout
          conn.options.open_timeout = Expedia.open_timeout.to_i if Expedia.open_timeout
        end
        conn
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
        args = common_parameters.merge(args)
        # figure out our options for this request
        request_options = {:params => (verb == :get ? args : {})}
        # set up our Faraday connection
        conn = Faraday.new(server(options), request_options)
        conn = add_timeouts(conn, options)
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

      # Creates a Signature for Expedia using MD5 Checksum Auth.
      # Shared and Api keys are required for Signature along with the current utc time.
      def signature
        if Expedia.cid && Expedia.api_key && Expedia.shared_secret
          Digest::MD5.hexdigest(Expedia.api_key + Expedia.shared_secret + Time.now.utc.to_i.to_s)
        else
          raise Expedia::AuthCredentialsError, "cid, api_key and shared_secret are required for Expedia Authentication."
        end
      end

      # Common Parameters required for every Call to Expedia Server.
      # @return [Hash] of all common parameters.
      def common_parameters
        { :cid => Expedia.cid, :sig => signature, :apiKey => Expedia.api_key, :minorRev => Expedia.minor_rev,
          :_type => 'json', :locale => Expedia.locale, :currencyCode => Expedia.currency_code }
      end

    end

  end
end
