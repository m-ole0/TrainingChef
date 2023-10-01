class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  validates :comment, presence: true

  private

  def create_notifications
    unless user == recipe.user
      Notification.create(subject: self, user: recipe.user, action_type: :commented_to_own_recipe)
    end
  end
end
