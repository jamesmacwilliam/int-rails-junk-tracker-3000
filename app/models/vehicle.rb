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

  # set defaults to simplify creation from a template
  before_validation do
    if vehicle_type_id_changed?
      self.doors = []
      self.parts = []
      copy_vehicle_type_parts if vehicle_type&.vehicle_type_parts.present?
      copy_doors if vehicle_type&.door_count&.positive?
    end
  end

  private

  def copy_doors
    vehicle_type.door_count.times do |n|
      doors.build(is_sliding: vehicle_type.sliding_door_count > n)
    end
  end

  def copy_vehicle_type_parts
    vehicle_type.vehicle_type_parts.each do |type_part|
      vehicle_parts.build(part_id: type_part.part_id, part_status_id: type_part.part_status_id)
    end
  end
end
