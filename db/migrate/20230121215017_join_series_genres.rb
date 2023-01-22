# frozen_string_literal: true

class JoinSeriesGenres < ActiveRecord::Migration[7.0]
  def change
    create_table "series_genres", id: false, force: :cascade do |t|
      t.integer "series_id", null: false
      t.integer "genre_id", null: false

      t.timestamps
    end
    add_index :series_genres, %i[series_id genre_id], unique: true
  end
end
