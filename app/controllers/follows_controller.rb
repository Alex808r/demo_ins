class FollowsController < ApplicationController
  before_action :authenticate_user!
  def create
    follower_user = current_user
    following_user = User.find(params[:following_id])
    Follow.create(follower: follower_user, following: following_user)
    #redirect_to users_path
    redirect_to user_followers_path(current_user)

  end

  def destroy
    follower_user = current_user
    following_user = User.find(params[:following_id])
    Follow.delete(follower: follower_user, following: following_user)
    redirect_to user_following_index_path(current_user)

  #   following_user = current_user
  #   follower_user = User.find(params[:following_id])
  #   Follow.delete(follower: following_user, following: follower_user)
  #     #redirect_to user_following_index_path(current_user)
   end
end
