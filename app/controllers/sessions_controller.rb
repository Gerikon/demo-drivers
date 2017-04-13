class SessionsController < ApplicationController
  # GET /login
  def new
    authorize :session
  end

  # POST /login
  def create
    authorize :session

    client = Welcomepickups::API::Client.new
    response = client.login(email: params[:user][:email], password: params[:user][:password])

    if response.successful?
      if response.json['result'] == 'OK'
        session['user'] = {}
        session['user']['email'] = params[:user][:email]
        session['user']['token'] = response.json['token']
        redirect_to dashboard_path, notice: 'Signed in successfully.'
      else
        flash.now[:alert] = response.json['result']
        render action: :new
      end
    else
      flash.now[:alert] = 'Server error. Sorry. Lets try later.'
      render action: :new
    end
  end

  # DELETE /session
  def destroy
    authorize :session

    session.delete('user')
    redirect_to login_path, notice: 'Signed out successfully.'
  end
end
