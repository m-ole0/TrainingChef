class Public::RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user.id)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user.id)
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.following_users.page(params[:page]).per(5)
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.follower_users.page(params[:page]).per(5)
  end
end
