class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized
  protect_from_forgery

  def current_user
    session[:user]
  end

  helper_method :current_user
end
