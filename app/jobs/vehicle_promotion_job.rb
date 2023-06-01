# background vehicle promotion to allow for synchronous vehicle crud
class VehiclePromotionJob < ApplicationJob
  # @param [Integer] vehicle_id of the Vehicle to be promoted
  def perform(vehicle_id)
    vehicle = Vehicle.find(vehicle_id)
    ad_text = AdBuilder.create_ad(vehicle)

    promote(vehicle, ad_text).tap do |promotion_id|
      vehicle.update(promotion_id: promotion_id, skip_promotion: true)
    end
  end

  def promote(vehicle, ad_text)
    return VehiclePromotionService.update_ad(vehicle.promotion_id, ad_text) if vehicle.promotion_id?

    VehiclePromotionService.create_ad(ad_text)
  end
end
