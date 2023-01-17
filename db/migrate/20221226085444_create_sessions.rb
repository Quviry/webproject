# frozen_string_literal: true

class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.belongs_to :user

      t.string :start_sign_in_ip
      t.string :current_sign_in_ip
      t.string :user_agent

      t.timestamps
    end
  end
end
