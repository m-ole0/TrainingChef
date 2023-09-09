class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
  end

  def edit
  end

  def update

  end

  def favorite_recipes
  end

  def following_recipes
  end

  def check
  end

  def destroy

  end
end
