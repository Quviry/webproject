# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: true
      t.references :episode, null: false

      t.timestamps
    end
    add_index :likes, %i[user_id episode_id], unique: true
  end
end
