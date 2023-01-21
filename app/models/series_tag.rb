# frozen_string_literal: true

# Join model (no use)
class SeriesTag < ApplicationRecord
  belongs_to :series
  belongs_to :tag
end
