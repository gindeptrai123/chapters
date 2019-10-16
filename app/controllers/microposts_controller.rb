class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t "msg.micropost_create"
      redirect_to root_path
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    @micropost.destroy
    if @micropost.destroy
      flash[:success] = t "msg.micropost_delete_success"
    else
      flash[:success] = t "msg.micropost_delete_fail"
    end
    redirect_to request.referrer || root_path
  end

  private

  def micropost_params
    params.require(:micropost).permit :content
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id]).od
    flash[:danger] = t "msg.micropost_id_invalid"
    redirect_to root_path if @micropost.nil?
  end
end
