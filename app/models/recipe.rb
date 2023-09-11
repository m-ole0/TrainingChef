class Recipe < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  has_one_attached :recipe_image

  validates :title, presence: true, length: { minimum: 2, maximum: 30 }
  validates :material, presence: true
  validates :process, presence: true
  validates :recipe_image, presence: true

  def save_tags(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(name: old_tag)
    end

    new_tags.each do |new_tag|
      tag = Tag.find_or_create_by(name: new_tag)
      self.tags << tag
    end
  end
end
