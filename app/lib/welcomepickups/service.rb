module Welcomepickups
  class Service
    def initialize(user = nil)
      @user = user
    end


    def get_schedule(from_date:, to_date:)
      raise ActionController::InvalidAuthenticityToken if @user.blank?
      return nil unless from_date.present? && to_date.present?
      
      client = Welcomepickups::API::Client.new(email: @user['email'], token: @user['token'])
      response = client.account_schedule(
          from_date: from_date,
          to_date:   to_date
      )

      days = response.json

      total_transfers    = 0
      total_requests     = 0
      count = 0

      days.each do |day|
        if day['transfer_available_to'].present? && day['transfer_available_from'].present? &&
            day['request_available_to'].present? && day['request_available_from'].present?

          total_transfers    += seconds_between(day['transfer_available_to'], day['transfer_available_from'])
          total_requests     += seconds_between(day['request_available_to'], day['request_available_from'])
          count += 1
        end
      end

      average_transfers  = count > 0 ? total_transfers / count : 0
      average_requests   = count > 0 ? total_requests / count : 0

      schedule = {}
      schedule[:days]              = days
      schedule[:total_transfers]   = total_transfers
      schedule[:total_requests]    = total_requests
      schedule[:average_transfers] = average_transfers
      schedule[:average_requests]  = average_requests
      schedule[:active_days]       = count

      schedule
    end


    private

    def seconds_between(t2, t1)
      Time.parse(t2).seconds_since_midnight - Time.parse(t1).seconds_since_midnight
    end
  end
end