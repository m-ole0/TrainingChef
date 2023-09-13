class SearchesController < ApplicationController
  def search
    @content = params[:content]
    @model = params[:model]
    if @model == 'user'
      @records = User.partial_search(@content)
    elsif @model == 'recipe'
      @records = Recipe.partial_search(@content)
    else
      @records = Tag.partial_search(@content)
    end
  end
end
