require 'json'

module Welcomepickups
  module API
    class Response
      attr_reader :status, :headers, :body, :json

      def initialize(response)
        @status  = response.status

        @body = response.body

        if body[0] == '{' || body[0] == '['
          @json = JSON.parse(body)
        else
          @json = nil
        end

        @headers = headers
      end

      def successful?
        case @status
          when 200..299
            true
          else
            false
        end
      end
    end
  end
end