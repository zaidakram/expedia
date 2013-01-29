module Expedia

  class ExpediaError < StandardError; end

  # Expedia respondes with status of 200 even if there is an exception (most of the time)
  class APIError < ::Expedia::ExpediaError

    # @status The HTTP status code of the response
    # @error_body The parsed response body
    # @error_info One of the following:
    # @category Value indicating the nature of the exception or the reason it occurred
    # @presentation_message Presentation error message returned
    # @verbose_message More specific detailed error message
    # @handling value indicating the severity of the exception and how it may be handled

    attr_accessor :category, :presentation_message, :verbose_message,
      :status, :error_body, :handling

    # Create a new API Error
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

    # Just to enable user to call this method on response object to know if any exception has occured
    # Free user form the Hastle of checking the class of object on every request.
    def exception?
      true
    end
  end

  # A standard Error calss for Raising exception if [cid, shared_secret, api_key] are not provided.
  class AuthCredentialsError < ::Expedia::ExpediaError; end

end
