# frozen_string_literal: true

# Like (from users only)
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :episode
end
