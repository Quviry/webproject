# frozen_string_literal: true

# Siries helper
module SeriesHelper
  def available_genres
    Genre.all
  end
end
