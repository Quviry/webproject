# frozen_string_literal: true

# Series of episodes
class Series < ApplicationRecord
  # relations
  has_many :series_tags, dependent: :delete_all
  has_many :tags, through: :series_tags

  has_many :series_genres, dependent: :delete_all
  has_many :genres, through: :series_genres

  has_many :episodes, dependent: :destroy

  has_many :views, through: :episodes, counter_cache: true
  has_many :likes, through: :episodes, counter_cache: true
  has_many :comments, through: :episodes, counter_cache: true

  has_many :subscriptions, dependent: :delete_all
  has_many :subscribed_user, through: :subscriptions, source: :series

  belongs_to :main_genre, class_name: "Genre", foreign_key: "genre_id", inverse_of: :genred_series

  belongs_to :user

  # attachments
  has_one_attached :thumbnail
  has_one_attached :cover do |attachable|
    attachable.variant :thumb, resize_to_limit: [90, 135]
  end

  # support_attributes
  attr_accessor :tags_list, :genres_list

  # validations
  validates :thumbnail, attached: { message: "Не добавлена миниатюра" },
                        content_type: { in: ["image/png", "image/jpg", "image/jpeg"],
                                        message: "Недопустимый формат миниатюры" },
                        dimension: { width: { min: 300, max: 300 },
                                     height: { min: 300, max: 300 }, message: "Недопустимый размер миниатюры" }

  validates :cover, attached: { message: "Не добавлена обложка" },
                    content_type: { in: ["image/png", "image/jpg", "image/jpeg"],
                                    message: "Недопустимый формат обложки" },
                    dimension: { width: { min: 960, max: 960 },
                                 height: { min: 1440, max: 1440 }, message: "Недопустимый размер обложки" }

  validates :title, presence: { message: "Не предоставлено название" }
  validates :url, presence: { message: "Нет URL" }
  validates :description, presence: { message: "Нет описания" }
  validates :genres, presence: { message: "Нет жанров" }
  validates :type, presence: { message: "Некорректный тип" }

  validates :title, length: { maximum: 100, message: "Название слишком длинное" }
  validates :url, uniqueness: { message: "URL уже занят" }
  validates :description, length: { maximum: 1000, message: "Описание слишком длинное" }
  validates :genres, length: { maximum: 3, message: "Выбрано более, чем 3 жанра" }

  before_validation do
    self.tags = (tags_list || []).map { |title| Tag.where(title:).first_or_create }
    self.genres = Genre.where(title: (genres_list || []))
    thumbnail.save
  end
end
