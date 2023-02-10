# frozen_string_literal: true

# Dashboard helper
module DashboardHelper
  def user_artist?(user)
    Series.exists?(user:)
  end

  def path_group
    case request.path
    when /episode/
      2
    when /performance/
      3
    else
      1
    end
  end

  def received_likes(user)
    user.collected_likes.size
  end

  def received_views(user)
    user.collected_views.size
  end

  def received_comments(user)
    user.collected_comments.size
  end
end
