class UsersController < ApplicationController
  include Pundit
  before_action :authenticate_user!

  def show
    # @user_cur = current_user
    @user = User.find(params[:id])
    @followers = Follow.select { |follower| follower.following_id == @user.id }
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_update_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy
    redirect_to users_path
  end


  private

  def user_update_params
    params.require(:user).permit(:username)
  end

end
