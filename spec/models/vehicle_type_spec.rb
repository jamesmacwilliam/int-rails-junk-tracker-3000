require 'rails_helper'

RSpec.describe VehicleType, type: :model do
  subject { build(:vehicle_type) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to have_many(:vehicle_type_parts).dependent(:destroy) }
  it { is_expected.to have_many(:parts).through(:vehicle_type_parts) }
end
