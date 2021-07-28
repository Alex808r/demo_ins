class FollowsController < ApplicationController
  before_action :authenticate_user!
  def create
    follower_user = current_user
    following_user = User.find(params[:following_id])
    Follow.create(follower: follower_user, following: following_user)
    #redirect_to users_path
    redirect_to user_following_index_path(current_user)

  end

  def destroy
    follower_user = current_user
    following_user = User.find(params[:following_id])
    Follow.where(follower: follower_user, following: following_user).delete_all
   # Follow.where(follower: follower_user, following: following_user).destroy_all
    redirect_to user_following_index_path(current_user)#home_path

   end
end
