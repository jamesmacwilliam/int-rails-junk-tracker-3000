class VehiclePart < ApplicationRecord
  belongs_to :vehicle
  belongs_to :part
  belongs_to :part_status

  delegate :name, to: :part, prefix: true, allow_nil: true
  delegate :name, to: :part_status, prefix: true, allow_nil: true
end
