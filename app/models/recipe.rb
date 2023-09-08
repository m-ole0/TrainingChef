class Recipe < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  has_one_attached :recipe_image
end
