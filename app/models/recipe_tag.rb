class RecipeTag < ApplicationRecord
  belongs_to :recipe_tag
  belongs_to :tags
end
