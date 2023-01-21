class ComicEpisode < Episode
  validates :pages, presence: true
  has_many_attached :pages
end
