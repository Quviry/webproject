# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false
      t.references :series, null: false

      t.timestamps
    end
    add_index :subscriptions, %i[user_id series_id], unique: true
  end
end
