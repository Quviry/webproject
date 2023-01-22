# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false
      t.references :episode, null: false
      t.references :comment, null: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
