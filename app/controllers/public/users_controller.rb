class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.page(params[:page])
    @recipes_all = @user.recipes
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def favorite_recipes
    user = current_user
    favorites = Favorite.where(user_id: user.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.where(id: favorites).page(params[:page])
  end

  def following_recipes
    user = current_user
    @following_recipes = Recipe.where(user_id: user.following_users).page(params[:page]).per(5)
  end

  def check
    @user = current_user
  end

  def destroy
    @user = current_user
    @user.destroy
    flash[:notice] = "ユーザーデータを削除しました。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email, :profile_image)
  end
end
