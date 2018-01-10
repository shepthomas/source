class AccountsController < ApplicationController

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user
    if @user.update(form_params)
      flash[:success] = "Your account has been updated"
      redirect_to root_path
    else
      render "edit"
    end
  end

  def form_params
    params.require(:user).permit(:subscription_plan)
  end

end
