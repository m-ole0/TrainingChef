class Admin::RecipesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @recipes = Recipe.all.order(created_at: :desc).page(params[:page])
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
    @recipe.recipe_image_params = params[:recipe][:recipe_image]
    if @recipe.update(recipe_params)
      flash[:notice] = "レシピを更新しました。"
      redirect_to admin_recipe_path(@recipe)
    else
      @tag_list = @recipe.tag_name
      render :edit
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
    @recipes = @tag.recipes.all.order(created_at: :desc).page(params[:page])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :material, :process, :recipe_image, :tag_name)
  end

  def prepare_and_render_edit(tag_list)
    @tag_list = tag_list.join(',')
    render "edit"
  end

end
