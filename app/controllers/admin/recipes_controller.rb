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
    tag_list = params[:recipe][:name].split(',')
    current_tags = @recipe.current_tags
    new_tags = @recipe.new_tags(tag_list, current_tags)
    if Tag.all_tags_valid?(new_tags)
      if @recipe.update(recipe_params)
        tag_list = tag_list.uniq
        @recipe.save_tags(tag_list, current_tags, new_tags)
        flash[:notice] = "レシピを更新しました。"
        redirect_to admin_recipe_path(@recipe)
      else
        prepare_and_render_edit(tag_list)
      end
    else
      @recipe.errors.add(:base, "タグは30文字以内にしてください。")
      prepare_and_render_edit(tag_list)
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
    params.require(:recipe).permit(:title, :material, :process, :recipe_image)
  end

  def prepare_and_render_edit(tag_list)
    @tag_list = tag_list.join(',')
    render "edit"
  end

end
