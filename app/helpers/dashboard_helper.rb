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
end
