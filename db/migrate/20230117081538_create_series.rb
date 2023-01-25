# frozen_string_literal: true

class CreateSeries < ActiveRecord::Migration[7.0]
  def change
    create_table :series do |t|
      t.string :type, null: false
      t.string :title, null: false, default: "", index: { unique: true }
      t.string :url, null: false, default: "", index: { unique: true }
      t.text :description
      t.references :genre, null: false

      t.integer :likes_count
      t.integer :views_count
      t.integer :comments_count

      # t.attachment :thumbnail
      # t.attachment :cover
      t.references :user, null: false, default: 0

      t.timestamps
    end
  end
end
