# frozen_string_literal: true

# Dashboard helper
module DashboardHelper
  def active_user_artist?
    Series.exists?(user: instance_variable_get(:@current_user))
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
    user.collected_likes.count
  end

  def received_views(user)
    user.collected_views.count
  end

  def received_comments(user)
    user.collected_comments.count
  end
end
