# frozen_string_literal: true

# Episode, data-containing part of Series
class Episode < ApplicationRecord
  # relations
  has_one_attached :thumbnail
  belongs_to :series
end
