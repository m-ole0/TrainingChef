class SearchesController < ApplicationController

  def search
    @content = params[:content]
    @model = params[:model]
    if @model == 'user'
      @records = User.partial_search(@content).page(params[:page]).per(5)
      @result_all = User.partial_search(@content)
    elsif @model == 'recipe'
      @records = Recipe.partial_search(@content).order(created_at: :desc).page(params[:page])
      @result_all = Recipe.partial_search(@content)
    else
      @records = Tag.partial_search(@content).page(params[:page]).per(5)
      @result_all = Tag.partial_search(@content)
    end
  end
end
