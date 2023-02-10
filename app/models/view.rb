# frozen_string_literal: true

# View(can be free) to episode
class View < ApplicationRecord
  belongs_to :user
  belongs_to :episode, counter_cache: true

  delegate :series, to: :episode
  belongs_to :series, counter_cache: true
end
