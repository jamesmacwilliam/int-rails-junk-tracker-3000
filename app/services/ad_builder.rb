class AdBuilder
  include ActionView::Helpers::NumberHelper

  attr_accessor :vehicle 

  # mileage indicators
  MILEAGE = {
    low: 20_000,
    medium: 100_000,
    high: nil,
  }.freeze

  def self.create_ad(vehicle)
    new(vehicle).call
  end

  def call
    ad.select(&:present?).join("\n") + "\n"
  end

  def initialize(vehicle)
    @vehicle = vehicle
  end

  private

  def mileage_indicator
    MILEAGE.find do |indicator, val|
      !val || vehicle.mileage < val
    end.first
  end

  def mileage
    return unless vehicle.mileage?

    "Mileage:#{delim}#{mileage_indicator.to_s.titleize} (#{number_with_delimiter(vehicle.mileage)})#{suffix}"
  end

  def registration
    return unless vehicle.registration_id?

    "Registration number:#{delim}#{vehicle.registration_id}#{suffix}"
  end

  def delim
    @delim ||= vehicle.stacked_ad? ? "\n" : " "
  end

  def suffix
    @suffix ||= vehicle.stacked_ad? ? "\n" : ""
  end

  def parts
    vehicle.vehicle_parts.includes(:part, :part_status).map do |vehicle_part| 
      "#{vehicle_part.part_name}:#{delim}#{vehicle_part.part_status_name}"
    end.join("\n\n")
  end

  def nickname
    return "\n#{vehicle.nickname}\n" if vehicle.headline? && vehicle.nickname?

    vehicle.nickname
  end

  def ad
    [
      vehicle.headline,
      nickname,
      registration,
      mileage,
      parts,
      doors,
    ]
  end

  def doors
    door_count = vehicle.doors.size
    sliding_door_count = vehicle.doors.select(&:is_sliding).size
    return unless sliding_door_count > 0

    [
      "Regular Doors:#{delim}#{door_count - sliding_door_count}",
      "Sliding Doors:#{delim}#{sliding_door_count}",
    ].join("\n")
  end
end
