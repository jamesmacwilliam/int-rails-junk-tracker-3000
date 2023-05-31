class CreateVehicleTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicle_types do |t|
      t.text :name
      t.boolean :has_doors, default: true, null: false
      t.boolean :has_sliding_doors, default: false, null: false
      t.boolean :has_seat, default: false, null: false
      t.integer :door_count, default: 0, null: false

      t.timestamps
    end
  end
end
