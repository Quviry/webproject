# frozen_string_literal: true

# Like (from users only)
class Like < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :episode

  validates :user, presence: true, on: :create
end
