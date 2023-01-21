# frozen_string_literal: true

class CreateSeriesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :series_tables, &:timestamps
  end
end
