class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:followings, :followers]

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

  private

  def is_matching_login_user
    user = User.find(params[:user_id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
