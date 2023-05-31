require 'rails_helper'

RSpec.describe VehicleTypePart, type: :model do
  subject { build(:vehicle) }

  it { is_expected.to have_many(:vehicle_parts).dependent(:destroy) }
  it { is_expected.to have_many(:parts).through(:vehicle_parts) }
end
