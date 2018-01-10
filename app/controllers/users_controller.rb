class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(form_params)

    # check if the user can save
    if @user.save_and_subscribe
      # keep hold of user across site
      session[:user_id] = @user.id

      # let user know that they signed up
      flash[:success] = "Thanks for signing up!"

      # redirect to home page
      redirect_to root_path


    else
      # otherwise re-show new signup page
      render "new"
    end

  end

  def form_params
    params.require(:user).permit(:name, :username,
      :email, :password, :password_confirmation, :subscription_plan, :stripe_token)
  end

end
