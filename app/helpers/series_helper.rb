# frozen_string_literal: true

# Siries helper
module SeriesHelper
  def available_genres
    Genre.all.pluck(:title)
  end
end
