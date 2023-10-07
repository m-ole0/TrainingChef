class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :week_favorites, -> { where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day) }

  has_one :notification, as: :subject, dependent: :destroy

  has_one_attached :recipe_image

  attr_accessor :recipe_image_params, :tag_name

  validates :title, presence: true, length: { minimum: 2, maximum: 30 }
  validates :material, presence: true
  validates :process, presence: true
  validates :recipe_image, presence: true

  validate :image_analysis, if: -> { recipe_image_params.present? }
  validate :set_tags

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.partial_search(content)
    Recipe.where('title LIKE ?', '%'+content+'%')
  end

  private

  def image_analysis
    result = Vision.image_analysis(recipe_image_params)
    unless result
      errors.add(:base, "画像が不適切です。別の画像を選択してください。")
    end
  end

  def set_tags
    new_tags = []
    tag_name.split(",").uniq.each do |name|
      tag = Tag.find_or_create_by(name: name)
      if tag.invalid?
        errors.add(:base, "タグは30文字以内にしてください。")
        return
      end
      new_tags << tag
    end

    recipe_tags.destroy_all
    new_tags.each do |tag|
      recipe_tags.new(tag_id: tag.id)
    end
  end
end
