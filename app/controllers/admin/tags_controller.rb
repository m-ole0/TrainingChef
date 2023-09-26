class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = Tag.all.page(params[:page]).per(10)
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if tag_exists_with_same_name?(tag_params[:name])
      @tag.errors.add(:base, "同じ名前のタグが存在します。")
      render 'edit'
    else
      if @tag.update(tag_params)
        flash[:notice] = "タグ情報を更新しました。"
        redirect_to admin_tags_path
      else
        render "edit"
      end
    end
  end

  def check
    @tag = Tag.find(params[:id])
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    flash[:notice] = "タグを削除しました。"
    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def tag_exists_with_same_name?(name)
    Tag.where(name: name).where.not(id: @tag.id).exists?
  end
end
