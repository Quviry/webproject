# frozen_string_literal: true

# Helper for session data
module SessionHelper
  def authorised?
    !instance_variable_get(:@current_user).nil?
  end

  def confirmed?
    user = instance_variable_get(:@current_user)
    user.nil? || user.confirmed
  end
end
