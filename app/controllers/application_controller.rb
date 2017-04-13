class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    session[:user]
  end

  helper_method :current_user
end
