# background vehicle registration to allow for synchronous vehicle creation
class VehicleRegistrationJob < ApplicationJob
  # @param [Integer] vehicle_id of the Vehicle to be promoted
  def perform(vehicle_id)
    vehicle = Vehicle.find(vehicle_id)

    VehicleRegistrationService.register_vehicle(vehicle).tap do |registration_id|
      vehicle.update(registration_id: registration_id)
      VehicleRegistrationsChannel.broadcast(vehicle)
    end
  end
end
