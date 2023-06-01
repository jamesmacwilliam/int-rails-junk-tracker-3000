class AddVehicleTypeToVehicles < ActiveRecord::Migration[6.1]
  def change
    add_reference :vehicles, :vehicle_type
  end
end
