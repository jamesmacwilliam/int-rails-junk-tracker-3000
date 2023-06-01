class CleanUpVehicleTypes < ActiveRecord::Migration[6.1]
  def change
    remove_column :vehicle_types, :has_doors
    remove_column :vehicle_types, :has_sliding_doors
    remove_column :vehicle_types, :has_seat

    add_column :vehicle_types, :sliding_door_count, :integer, default: 0, null: false
  end
end
