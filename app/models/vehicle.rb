class Vehicle < ApplicationRecord
  validates :nickname, presence: true

  has_many :doors, dependent: :destroy
  has_many :vehicle_parts, dependent: :destroy
  has_many :parts, through: :vehicle_parts
end
