# frozen_string_literal: true

class CreateGenresTable < ActiveRecord::Migration[7.0]
  def change
    create_table :genres do |t|
      t.string :title, index: { unique: true }

      t.timestamps
    end
  end
end
