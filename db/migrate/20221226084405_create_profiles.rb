# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user

      t.string :display_name
      t.string :location
      t.string :about

      t.timestamps
    end
    add_index :profiles, :display_name, unique: true
  end
end
