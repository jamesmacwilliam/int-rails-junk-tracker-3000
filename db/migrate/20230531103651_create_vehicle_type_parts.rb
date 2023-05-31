class CreateVehicleTypeParts < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicle_type_parts do |t|
      t.references :vehicle_type
      t.references :part
      t.references :part_status

      t.timestamps
    end
  end
end
