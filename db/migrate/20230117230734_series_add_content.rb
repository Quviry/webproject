# frozen_string_literal: true

class SeriesAddContent < ActiveRecord::Migration[7.0]
  def change
    add_column :series, :title, :string
    add_column :series, :url, :string
    add_column :series, :description, :text

    add_column :series, :thumbnail, :attachment
    add_column :series, :cover, :attachment
  end
end
