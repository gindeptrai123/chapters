class AccountActivationsController < ApplicationController
  before_action :load_user, only: :edit

  def edit
    @user.activate
    log_in @user
    flash[:success] = t "msg.acount_active_success"
    redirect_to @user
  end

  private

  def load_user
    @user = User.find_by email: params[:email]
    if @user && !@user.activated?
      authenticated @user
    else
      flash[:danger] = t "msg.acount_done_active"
      redirect_to root_url
    end
  end

  def authenticated user
    return if user.authenticated?(:activation, params[:id])
    flash[:danger] = t "msg.acount_active_fail"
    redirect_to root_url
  end
end
