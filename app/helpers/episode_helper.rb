# frozen_string_literal: true

# Helper for episode display
module EpisodeHelper
  def episode_summary_stat(episode)
    [episode_views(episode), episode_likes(episode), episode_comments(episode)].join(" ● ")
  end

  def episode_views(episode)
    count = episode.views.count
    "#{number_to_human count} #{I18n.t('view', count:)}"
  end

  def episode_likes(episode)
    count = episode.likes.count
    "#{number_to_human count} #{I18n.t('like', count:)}"
  end

  def episode_comments(episode)
    count = episode.comments.count
    "#{number_to_human count} #{I18n.t('comment', count:)}"
  end
end
