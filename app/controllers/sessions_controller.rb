class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(username:params[:username], email:params[:email])
    if user and user.authenticate(params[:password])
      sessions[:user_id] = user.id
      redirect_to dashboard_url
    else
      redirect_to login_url, alert: "Invalid Username or password"
    end
  end

  def destroy
    sessions[:user_id] = nil
    redirect_to login_url, alert: "Successfully logged out"
  end
end
