# frozen_string_literal: true

# Tag for tagging models Series and Episodes
class Tag < ApplicationRecord
  has_many :series_tags, dependent: :destroy
  has_many :series, through: :series_tags
  # title
end
