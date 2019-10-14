class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def show
    @microposts = @user.microposts.paginate page: params[:page]
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "msg.check_active"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "msg.profile_update_success"
      redirect_to @user
    else
      flash[:danger] = t "msg.profile_update_fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "msg.user_delete_success"
    else
      flash[:danger] = t "msg.user_delete_fail"
    end
    redirect_to users_url
  end

  def following
    @title = t "following"
    @users = @user.following.paginate page: params[:page]
    render "show_follow"
  end

  def followers
    @title = t "followers"
    @users = @user.followers.paginate page: params[:page]
    render "show_follow"
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "msg.f_user_fail"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin
  end
end
