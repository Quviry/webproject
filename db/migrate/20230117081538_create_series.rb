# frozen_string_literal: true

class CreateSeries < ActiveRecord::Migration[7.0]
  def change
    create_table :series, &:timestamps
  end
end
