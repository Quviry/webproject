# frozen_string_literal: true

# Page comment under episode (to comment)
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :episode
  belongs_to :comment
end
