class Vehicle < ApplicationRecord
  attr_accessor :skip_promotion
  validates :nickname, presence: true

  has_many :doors, dependent: :destroy
  has_many :vehicle_parts, dependent: :destroy
  has_many :parts, -> { order(:name) }, through: :vehicle_parts

  belongs_to :vehicle_type

  after_commit do
    if !registration_id?
      VehicleRegistrationJob.perform_later(id)
    elsif !skip_promotion
      VehiclePromotionJob.perform_later(id)
    end
  end
end
