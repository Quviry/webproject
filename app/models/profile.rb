# frozen_string_literal: true

# Profile, connected to user data
class Profile < ApplicationRecord
  belongs_to :user, class_name: "user"
end
