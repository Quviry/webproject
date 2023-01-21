class AlterSeries < ActiveRecord::Migration[7.0]
  def change
    add_column :series, :user_id, :belongs_to , null: false, default: 0
  end
end
