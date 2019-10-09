class PasswordResetsController < ApplicationController
  before_action :load_user, only: :create
  before_action :get_user, :valid_user, :check_expiration,
    only: [:edit, :update]

  def new; end

  def edit; end

  def create
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:info] = t "msg.info_email"
    redirect_to root_url
  end

  def update
    @user.assign_attributes user_params
    if @user.save(context: :update_password)
      log_in @user
      @user.update_attribute :reset_digest, nil
      flash[:success] = t "msg.reset_pass_done"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def load_user
    @user = User.find_by email: params[:password_reset][:email].downcase
    return if @user
    flash[:danger] = t "msg.email_not_found"
    render :new
  end

  def get_user
    @user = User.find_by email: params[:email]
    return if @user
    flash[:danger] = t "msg.f_user_fail"
    redirect_to root_path
  end

  def valid_user
    return if @user && @user.activated? &&
              @user.authenticated?(:reset, params[:id])
    flash[:danger] = t "msg.acount_not_active"
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "msg.pass_has_expire"
    redirect_to new_password_reset_url
  end
end
