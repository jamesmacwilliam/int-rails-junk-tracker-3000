require 'rails_helper'

RSpec.describe VehicleTypePart, type: :model do
  subject(:record) { build(:vehicle) }

  it { is_expected.to have_many(:vehicle_parts).dependent(:destroy) }
  it { is_expected.to have_many(:parts).through(:vehicle_parts) }

  it { is_expected.to belong_to(:vehicle_type) }

  describe "callbacks" do
    context "on create" do
      it "triggers vehicle registration and promotion service" do
        allow(VehicleRegistrationService).to receive(:register_vehicle).and_return("test")
        allow(VehiclePromotionService).to receive(:create_ad).and_return("test")
        perform_enqueued_jobs { record.save }
        expect(VehicleRegistrationService).to have_received(:register_vehicle)
        expect(VehiclePromotionService).to have_received(:create_ad)
      end
    end

    context "on update" do
      it "triggers promotion service only" do
        record.promotion_id = "test 123"
        record.save
        allow(VehicleRegistrationService).to receive(:register_vehicle).and_return("test")
        allow(VehiclePromotionService).to receive(:update_ad).and_return("test")
        perform_enqueued_jobs { record.update(nickname: "test 456") }
        expect(VehicleRegistrationService).not_to have_received(:register_vehicle)
        expect(VehiclePromotionService).to have_received(:update_ad)
      end
    end
  end
end
