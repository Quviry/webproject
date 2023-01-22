# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: "", index: { unique: true }
      t.string :encrypted_password, null: false, default: ""
      t.string :login, index: { unique: true }
      t.boolean :confirmed

      t.timestamps
    end
  end
end
