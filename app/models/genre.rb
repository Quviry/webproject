# frozen_string_literal: true

# Genre of Series
class Genre < ApplicationRecord
  has_many :series_genres, dependent: :restrict_with_exception
  has_many :series, through: :series_genres

  has_many :genred_series, class_name: "Series", dependent: :nullify
end
