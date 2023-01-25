# frozen_string_literal: true

class CreateProfileActivators < ActiveRecord::Migration[7.0]
  def change
    create_table :profile_activators do |t|
      t.references :user, null: false, index: { unique: true }
      t.string :code, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
