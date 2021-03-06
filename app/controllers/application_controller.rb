class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate, :set_user
  after_action :clear_xhr_flash
  
  protected
  
  def authenticate
    if cookies[:user_info]
      user_info = cookies.encrypted[:user_info]
      authorize user_info
    else
      reset_session
      redirect_to login_url, notice: "You are not authorised"
    end
  end

  def authorize(user_info)
    session[:current_user_info] = user_info
  end

  def clear_xhr_flash
    if request.xhr?
      flash.discard
    end
  end

  private

    def set_user
      if session[:current_user_info]
        @user_id = session[:current_user_info]["id"] || nil
        @staff_id = session[:current_user_info]["username"] || nil
        @user_email = session[:current_user_info]["email"] || nil
        @user_profile = Profile.find_by(user_id: @user_id)
      end
    end

end
