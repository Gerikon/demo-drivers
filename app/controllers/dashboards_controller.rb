class DashboardsController < ApplicationController
  def show
    unless current_user.present?
      skip_authorization
      redirect_to login_path, alert: 'Authorization is required.'
      return
    end

    authorize :dashboard

    @from_date = params.fetch(:dates, {})[:from_date]
    @to_date =   params.fetch(:dates, {})[:to_date]

    service = Welcomepickups::Service.new(current_user)
    @schedule = service.get_schedule(from_date: @from_date, to_date: @to_date)
  end
end
