# frozen_string_literal: true

# Siries helper
module SeriesHelper
  def available_genres
    Genre.all
  end

  def series_views_subscribers(series)
    [series_views(series), series_comments(series)].join(" ● ")
  end

  def series_views(series)
    count = series.views.size
    "#{number_to_human count} #{I18n.t('view', count:)}"
  end

  def series_likes(series)
    count = series.likes.size
    "#{number_to_human count} #{I18n.t('like', count:)}"
  end

  def series_comments(series)
    count = series.comments.size
    "#{number_to_human count} #{I18n.t('comment', count:)}"
  end

  def episodes_count(series)
    count = series.episodes.size
    "#{count} #{I18n.t('episode', count:)}"
  end
end
