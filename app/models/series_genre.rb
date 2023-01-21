# frozen_string_literal: true

# Join model (no use)
class SeriesGenre < ApplicationRecord
  belongs_to :genre
  belongs_to :series
end
