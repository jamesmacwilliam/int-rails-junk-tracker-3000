class VehiclePart < ApplicationRecord
  belongs_to :vehicle
  belongs_to :part
  belongs_to :part_status
end
