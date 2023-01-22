# frozen_string_literal: true

# View(can be free) to episode
class View < ApplicationRecord
  belongs_to :user
  belongs_to :episode
end
