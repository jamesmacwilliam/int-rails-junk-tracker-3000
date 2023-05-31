class VehicleTypePart < ApplicationRecord
  belongs_to :vehicle_type
  belongs_to :part
  belongs_to :part_status
end
