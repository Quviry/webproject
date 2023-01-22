# frozen_string_literal: true

# Episode, data-containing part of Series
class Episode < ApplicationRecord
  # relations
  has_many :views, dependent: :delete_all

  has_many :likes, dependent: :delete_all

  has_many :comments, dependent: :delete_all

  belongs_to :series
  # attachments
  has_one_attached :thumbnail

  # validations
  before_validation do
    self.scene = Episode.where(series_id:).count + 1
  end
end
