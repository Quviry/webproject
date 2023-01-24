# frozen_string_literal: true

# Episode, data-containing part of Series
class Episode < ApplicationRecord
  # relations
  has_many :views, dependent: :delete_all

  has_many :likes, dependent: :delete_all

  has_many :comments, dependent: :delete_all

  belongs_to :series, touch: true

  # attachments
  has_one_attached :thumbnail

  # fields
  # attr_accessor :title, :schedule_date, :nsfw, :comments_enabled

  # scopes
  scope :published, -> { where(schedule_date: ..Time.zone.now) }

  # validations

  validates :title, presence: true, uniqueness: { scope: :series }, length: { maximum: 100 }
  validates :nsfw, inclusion: { in: [true, false] }
  validates :comments_enabled, inclusion: { in: [true, false] }
  validates :schedule_date, comparison: { greater_than: Time.zone.now }, allow_blank: true
  validates :thumbnail, attached: true,
                        content_type: { in: ["image/png", "image/jpg", "image/jpeg"] },
                        dimension: { width: { min: 300, max: 300 },
                                     height: { min: 300, max: 300 } }

  before_validation do
    self.scene = series.episodes.count + 1 if scene.nil?
  end

  after_destroy do
    # rubocop:disable Rails/SkipsModelValidations
    Episode.update_counters(series.episodes.where(scene: scene..), scene: -1)
    # rubocop:enable Rails/SkipsModelValidations
  end
end
