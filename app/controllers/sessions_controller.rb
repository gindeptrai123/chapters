class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def new; end

  def create
    log_in @user
    params[:session][:remember_me] == Settings.session_check ? remember(@user) : forget(@user)
    redirect_to @user
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
