class CreateVehicleParts < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicle_parts do |t|
      t.references :vehicle
      t.references :part
      t.references :part_status

      t.timestamps
    end
  end
end
