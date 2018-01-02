class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # turn @current_user into a helper so it can be used in views
  helper_method :current_user

  # run this on every single page and action
  before_action :current_user

  def current_user
    if session[:user_id].present?
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
    @current_user
  end

end
