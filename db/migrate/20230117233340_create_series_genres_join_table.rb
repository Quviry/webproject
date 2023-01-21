# frozen_string_literal: true

class CreateSeriesGenresJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :series, :genres
  end
end
