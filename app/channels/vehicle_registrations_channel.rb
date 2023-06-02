class VehicleRegistrationsChannel < ApplicationCable::Channel
  # pub sub name
  CHANNEL_NAME = "vehicle_registrations"

  def self.broadcast(vehicle)
    ActionCable.server.broadcast(CHANNEL_NAME, vehicle.to_json)
  end
  def subscribed
    stream_from CHANNEL_NAME
  end

  def unsubscribe
    stop_all_streams
  end
end
