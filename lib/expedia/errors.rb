module Expedia

  class ExpediaError < StandardError; end

  # Expedia responded with status of 200 even if there is an exception (most of the time)
  class APIError < ::Expedia::ExpediaError
    attr_accessor :category, :presentation_message, :verbose_message,
                  :status, :error_body, :handling

    # Create a new API Error
    #
    # @param status [Integer] The HTTP status code of the response
    # @param error_body The parsed response body
    # @param error_info One of the following:
    #                   [Hash] The error information extracted from the request 
    #                          ("type", "code", "error_subcode", "message")
    #                   [String] The error description
    #                   If error_info is nil or not provided, the method will attempt to extract
    #                   the error info from the response_body
    #
    # @return the newly created APIError
    def initialize(status, body)
      @error_body = body
      @status = status

      begin
        @error_body = @error_body[@error_body.keys[0]]['EanWsError']
      rescue
      end

      unless @error_body.nil? || @error_body.empty?
        @category = error_body['category']
        @presentation_message = error_body['presentationMessage']
        @verbose_message = error_body['verboseMessage']
        @handling = error_body['handling']
        error_array = []
      end
      
      super(@verbose_message)

    end
  end

  # A standard Error calss for Raising exception if [cid, shared_secret, api_key] are not provided.
  class AuthCredentialsError < ::Expedia::ExpediaError; end

end
