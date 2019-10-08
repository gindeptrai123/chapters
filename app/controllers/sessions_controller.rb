class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def new; end

  def create
    log_in @user
    if @user.activated?
      if params[:session][:remember_me] == Settings.session_check
        remember @user
      else
        forget @user
      end
      redirect_back_or @user
    else
      flash[:warning] = t("msg.acount_not_active") + t("msg.check_your_email")
      redirect_to root_url
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user && @user.authenticate(params[:session][:password])
    flash.now[:danger] = t "msg.email_pass_fail"
    render :new
  end
end
