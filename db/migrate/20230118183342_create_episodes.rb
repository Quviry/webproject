class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.string :title, null: false
      t.datetime :schedule_date
      t.text :description
      t.boolean :nsfw, null: false, default: false
      t.boolean :comments_enabled, null: false, default: true
      t.belongs_to :series, null: false, foreign_key: true
      t.string :type, null: false

      t.timestamps
    end
    add_index :episodes, [:title, :series_id], unique: true
  end
end
