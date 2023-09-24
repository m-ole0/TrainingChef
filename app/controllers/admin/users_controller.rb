class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def show
     @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
      flash[:notice] = "ゲストユーザーの更新・削除はできません"
      redirect_to admin_user_path(@user)
    else
      if @user.update(user_params)
        flash[:notice] = "ユーザー情報を更新しました。"
        redirect_to admin_user_path(@user)
      else
        render "edit"
      end
    end
  end

  def check
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
      flash[:notice] = "ゲストユーザーの更新・削除はできません"
      redirect_to admin_user_path(@user)
    else
      @user.destroy
      flash[:notice] = "ユーザーデータを削除しました。"
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :emaii, :profile_image)
  end
end
