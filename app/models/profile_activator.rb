# frozen_string_literal: true

# Simple model to validate users
class ProfileActivator < ApplicationRecord
  belongs_to :user, class_name: "User"
  validates :user, uniqueness: true
  validates :code, presence: true

  before_validation do
    self.code = SecureRandom.uuid
    ProfileActivator.find_by(user:).destroy if ProfileActivator.exists?(user:, created_at: ..1.minute.ago)
  end

  after_create do
    ProfileActivatorMailer.with(user:, code:).activation_email.deliver_later
  end
end
