require 'welcomepickups/api/rest_methods'
require 'welcomepickups/api/response'

module Welcomepickups
  module API
    class Client
      include RestMethods

      def initialize(options = {})
        @user_email = options[:user_email]
        @user_token = options[:user_token]
      end

      def login(email:, password:)
        post('/login', email: email, password: password, attempt_counter: 1)
      end
    end
  end
end