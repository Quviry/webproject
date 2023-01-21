class Episode < ApplicationRecord
  has_one_attached :thumbnail
  belongs_to :series


end
