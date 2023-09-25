class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, except: [:show]
  before_action :ensure_normal_user, only: [:update, :destroy]

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(created_at: :desc).page(params[:page])
    @recipes_all = @user.recipes
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def favorite_recipes
    user = User.find(params[:id])
    favorites = Favorite.where(user_id: user.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.where(id: favorites).order(created_at: :desc).page(params[:page])
  end

  def following_recipes
    user = User.find(params[:id])
    @following_recipes = Recipe.where(user_id: user.following_users).order(created_at: :desc).page(params[:page]).per(5)
  end

  def check
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザーデータを削除しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def ensure_normal_user
    user = current_user
    if user.email == 'guest@example.com'
      flash[:notice] = "ゲストユーザーの更新・削除はできません"
      redirect_to user_path(user)
    end
  end

end
