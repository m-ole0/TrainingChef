class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
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
  end

  def following_recipes
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