module Expedia
  
  module HTTPService

    class Response

      attr_reader :status, :body, :headers

      # Creates a new Response object, which standardizes the response received From Expedia.
      def initialize(status, body, headers)
        @status = status
        @body = MultiJson.load(body) rescue ''
        @headers = headers
      end

      def exception?
        @body && @body[@body.keys[0]]['EanWsError'] ? true : false
      end

    end

  end
  
end
