class Public::RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :is_matching_login_user, only: [:edit, :update, :check, :destroy, :favorites]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    @recipe.recipe_image_params = params[:recipe][:recipe_image]

    if @recipe.save
      redirect_to user_path(current_user), notice: "投稿に成功しました。"
    else
      @tag_list = @recipe.tag_name
      render :new
    end
  end

  def index
    to = Time.current.at_end_of_day
    from = 1.week.ago.at_beginning_of_day
    sorted_recipes = Recipe.includes(:favorites).sort_by { |recipe| -recipe.favorites.where(created_at: from...to).count }
    @recipes = Kaminari.paginate_array(sorted_recipes).page(params[:page]).per(5)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_tags = @recipe.tags
    @comment = Comment.new
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
      redirect_to recipe_path(@recipe)
    else
      @tag_list = @recipe.tag_name
      render :edit
    end
  end

  def check
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = "レシピを削除しました。"
    redirect_to user_path(current_user)
  end

  def favorites
    recipe = Recipe.find(params[:id])
    @users = recipe.favorited_users.page(params[:page]).per(5)
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

  def is_matching_login_user
    recipe = Recipe.find(params[:id])
    unless recipe.user == current_user
      redirect_to user_path(current_user)
    end
  end

  def prepare_and_render_edit(tag_list)
    @tag_list = tag_list.join(',')
    render "edit"
  end
end
