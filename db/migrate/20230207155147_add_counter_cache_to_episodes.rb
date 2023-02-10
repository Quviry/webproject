# frozen_string_literal: true

class AddCounterCacheToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :likes_count, :integer, default: 0
    add_column :episodes, :views_count, :integer, default: 0
    add_column :episodes, :comments_count, :integer, default: 0
  end
end
