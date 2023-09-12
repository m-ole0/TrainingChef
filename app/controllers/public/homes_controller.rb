class Public::HomesController < ApplicationController
  def top
    to = Time.current.at_end_of_day
    from = 1.week.ago.at_beginning_of_day
    @recipes = Recipe.includes(:favorites).sort_by { |recipe| -recipe.favorites.where(created_at: from...to).count }
  end
end
