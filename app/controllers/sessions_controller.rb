class SessionsController < ApplicationController
  # GET /login
  def new
  end

  # POST /login
  def create
  end

  private
    def session_params
      params.fetch(:session, {})
    end
end
