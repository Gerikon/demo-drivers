require 'welcomepickups/api/rest_methods'
require 'welcomepickups/api/response'

module Welcomepickups
  module API
    class Client
      include RestMethods

      def initialize(email: nil, token: nil)
        @user_email = email
        @user_token = token
      end

      def login(email:, password:)
        post('/login', email: email, password: password, attempt_counter: 1)
      end

      def account_schedule(from_date:, to_date:)
        get('/account/schedule', from_date: from_date, to_date: to_date)
      end
    end
  end
end