class AccountsController < ApplicationController

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user

    if @user.update_with_stripe(form_params)
      flash[:success] = "Your account has been updated"
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    # deletes and unsubscribes
    @current_user.destroy_and_unsubscribe

    # remove the session
    reset_session

    # redirect to sign up page
    redirect_to root_path
    
  end

  def form_params
    params.require(:user).permit(:subscription_plan)
  end

end
