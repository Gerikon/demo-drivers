class DashboardsController < ApplicationController
  def show
    @from_date = params.fetch(:dates, {})[:from_date]
    @to_date =   params.fetch(:dates, {})[:to_date]

    service = Welcomepickups::Service.new(current_user)
    @schedule = service.get_schedule(from_date: @from_date, to_date: @to_date)
  end
end
