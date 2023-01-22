# frozen_string_literal: true

class CreateViews < ActiveRecord::Migration[7.0]
  def change
    create_table :views do |t|
      t.references :user, null: true
      t.references :episode, null: false

      t.timestamps
    end
    add_index :views, %i[user episode], unique: true
  end
end
