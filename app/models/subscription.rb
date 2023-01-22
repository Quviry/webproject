# frozen_string_literal: true

# Subscription (from user to series)
class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :series
end
