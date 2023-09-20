class Admin::RecipesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @recipes = Recipe.all.page(params[:page])
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_tags = @recipe.tags
  end

  def check
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @tag_list = @recipe.tags.pluck(:name).join(',')
  end

  def update
    @recipe = Recipe.find(params[:id])
    tag_list=params[:recipe][:name].split(',')
    if @recipe.update(recipe_params)
      @recipe.save_tags(tag_list)
      flash[:notice] = "レシピを更新しました。"
      redirect_to admin_recipe_path(@recipe)
    else
      render "edit"
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = "レシピを削除しました。"
    redirect_to admin_recipes_path
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes.all
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :material, :process, :recipe_image)
  end
end
