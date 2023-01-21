# frozen_string_literal: true

class SeriesAddType < ActiveRecord::Migration[7.0]
  def change
    add_column :series, :type, :string, null: false
  end
end
