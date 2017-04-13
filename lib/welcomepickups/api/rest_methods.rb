require 'faraday'

module Welcomepickups
  module API
    module RestMethods
      def get(path, params = {})
        request('get', path, params)
      end

      def post(path, body = {}, params = {})
        request('post', path, params, body)
      end

      def put(path, body = {}, params = {})
        request('put', path, params, body)
      end

      def request(method, path, params = {}, body = {})
        conn = Faraday.new(url: ENV['WELCOME_API_HOST']) do |faraday|
          # faraday.basic_auth(@login, @password)
          if @user_token
            faraday.options.context = {
                'X-User-Email': @user_email,
                'X-User-Token': @user_token
            }
          end

          faraday.request  :url_encoded             # form-encode POST params
          # faraday.response :logger                  # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP # Needs to be last!
        end

        path = "#{ENV['WELCOME_API_PATH']}#{path}"

        uri = URI(path)
        uri.query = params.to_query

        response = case method
                     when 'get'
                       conn.get(path, params)
                     when 'post'
                       conn.post(path) do |req|
                         req.body = body
                       end
                     when 'put'
                       conn.put(path, params)
                     else
                       raise ArgumentError, "Incorrect method ##{method}"
                   end

        Welcomepickups::API::Response.new(response)
      end
    end
  end
end