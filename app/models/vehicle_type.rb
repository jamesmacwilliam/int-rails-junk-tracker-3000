class VehicleType < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :vehicle_type_parts, dependent: :destroy
  has_many :parts, through: :vehicle_type_parts
end
