class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # turn @current_user into a helper so it can be used in views
  helper_method :current_user, :is_logged_in?

  # run this on every single page and action
  before_action :current_user

  def current_user
    if is_logged_in?
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
    @current_user
  end

  def is_logged_in?
    session[:user_id].present?
  end

  def force_login
    unless is_logged_in?
      # unless logged in, redirect to sign up
      flash[:error] = "You are not logged in"
      redirect_to new_user_path
    end
  end

end
