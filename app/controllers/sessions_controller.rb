class SessionsController < ApplicationController
  # GET /login
  def new
  end

  # POST /login
  def create
    client = Welcomepickups::API::Client.new(server: 'crm.welcomepickups.com')
    response = client.login(email: params[:user][:email], password: params[:user][:password])

    if response.json['result'] == 'OK'
      session[:user] = {}
      session[:user][:token] = response.json['token']
      redirect_to login_path, notice: 'Signed in successfully'
    else
      flash.now[:alert] = response.json['result']
      render action: :new
    end
  end
end
