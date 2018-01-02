class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(form_params)

    # check if the user can save
    if @user.save
      # redirect to home page
      redirect_to root_path
    else
      # otherwise re-show new signup page
      render "new"
    end

  end

  def form_params
    params.require(:user).permit(:name, :username,
      :email, :password, :password_confirmation)
  end

end
