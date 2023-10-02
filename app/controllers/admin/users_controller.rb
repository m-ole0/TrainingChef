class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_normal_user, only: [:update, :destroy]

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
    if user_params[:profile_image].present?
      result = Vision.image_analysis(user_params[:profile_image])
      if result
        if @user.update(user_params)
          flash[:notice] = "ユーザー情報を更新しました。"
          redirect_to admin_user_path(@user)
        else
          render "edit"
        end
      else
        @user.errors.add(:base, "画像が不適切です。別の画像を選択してください。")
        render "edit"
      end
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
    @user.destroy
    flash[:notice] = "ユーザーデータを削除しました。"
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email, :profile_image)
  end

  def ensure_normal_user
    user = User.find(params[:id])
    if  user.email == 'guest@example.com'
      flash[:notice] = "ゲストユーザーの更新・削除はできません"
      redirect_to admin_user_path(user)
    end
  end
end
