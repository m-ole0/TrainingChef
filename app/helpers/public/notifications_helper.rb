module Public::NotificationsHelper
  def transition_path(notification)
    case notification.action_type.to_sym
    when :commented_to_own_recipe
      recipe_path(notification.subject.recipe, anchor: "comment-#{notification.subject.id}")
    when :liked_to_own_post
      recipe_path(notification.subject.recipe)
    when :followed_me
      user_path(notification.subject.follower)
    end
  end
end
