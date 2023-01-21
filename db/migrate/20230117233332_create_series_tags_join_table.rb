# frozen_string_literal: true

class CreateSeriesTagsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :series, :tags
  end
end
