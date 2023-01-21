# frozen_string_literal: true

# Application models highest abstraction
class Series < ApplicationRecord
  has_one_attached :thumbnail
  validates :thumbnail, attached: {message: "Не добавлена миниатюра"},
   content_type: {in: ['image/png', 'image/jpg', 'image/jpeg'], message: "Недопустимый формат миниатюры"},
      dimension: { width: { min: 300, max: 300 },
                  height: { min: 300, max: 300 }, message: 'Недопустимый размер миниатюры' }
  has_one_attached :cover do |attachable|
    attachable.variant :thumb, resize_to_limit: [90, 135]
  end

  attr_accessor :tags_list, :genres_list
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :genres
  has_many :episodes, dependent: :destroy
  belongs_to :user

  validates :title, presence: { message: "Не предоставлено название" }
  validates :url, presence: { message: "Нет URL" }
  validates :description, presence: { message: "Нет описания" }
  validates :genres, presence: { message: "Нет жанров" }
  validates :type, presence: { message: "Некорректный тип" }

  validates :title, length: { maximum: 100, message: "Название слишком длинное" }
  validates :url, uniqueness: { message: "URL уже занят" }
  validates :description, length: { maximum: 100, message: "Описание слишком длинное" }
  validates :genres, length: {in: 1..3, message: "Выбрано более, чем 3 жанра"}

  before_validation do
    self.tags = (tags_list || []).map{ |title| Tag.where(title: title).first_or_create()}
    self.genres = (genres_list || []).map{ |title| Genre.where(title: title).first()}
    p user_id
  end

  after_validation do

  end
end
