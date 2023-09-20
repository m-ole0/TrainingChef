class Tag < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy
  has_many :recipes, through: :recipe_tags

  validates :name, presence: true, length: { maximum: 30 }

  def self.partial_search(content)
    Tag.where('name LIKE ?', '%'+content+'%')
  end

end
