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
    copy_vehicle_type_parts if parts.blank? && vehicle_type&.vehicle_type_parts.present?
    copy_doors if doors.blank? && vehicle_type&.doors.present?
  end

  private

  def copy_doors
    vehicle_type.doors.each do |door|
      doors.build(is_sliding: door.is_sliding)
    end
  end

  def copy_vehicle_type_parts
    vehicle_type.vehicle_type_parts.each do |type_part|
      vehicle_parts.build(part_id: type_part.part_id, part_status_id: type_part.part_status_id)
    end
  end
end
