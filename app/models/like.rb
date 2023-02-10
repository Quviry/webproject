# frozen_string_literal: true

# Like (from users only)
class Like < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :episode, counter_cache: true

  delegate :series, to: :episode
  belongs_to :series, counter_cache: true

  validates :user, presence: true, on: :create
end
