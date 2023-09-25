class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  validates_uniqueness_of :recipe_id, scope: :user_id

  private

  def  create_notifications
    Notification.create(subject: self, user: self.recipe.user, action_type: :liked_to_own_recipe)
  end
end
