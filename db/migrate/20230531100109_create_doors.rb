class CreateDoors < ActiveRecord::Migration[6.1]
  def change
    create_table :doors do |t|
      t.boolean :is_sliding, default: false, null: false
      t.references :vehicle

      t.timestamps
    end
  end
end
