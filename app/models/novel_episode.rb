# frozen_string_literal: true

# Episode of Novel, contain rich text
class NovelEpisode < Episode
  has_rich_text :story
end
