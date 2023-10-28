class Public::HomesController < ApplicationController
  def top
    @recipes = Recipe.left_outer_joins(:favorites)
             .select('recipes.*, COUNT(favorites.id) AS favorites_count')
             .group('recipes.id')
             .order('favorites_count DESC')
  end
end
