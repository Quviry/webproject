# frozen_string_literal: true

# Profile, connected to user data
class Profile < ApplicationRecord
  # relations
  belongs_to :user, class_name: "user"

  # attachments
  has_one_attached :avatar
end
