# frozen_string_literal: true

# Episode of Comics
class ComicEpisode < Episode
  # relations
  has_many_attached :pages

  # validations
  validates :pages, presence: true
end
