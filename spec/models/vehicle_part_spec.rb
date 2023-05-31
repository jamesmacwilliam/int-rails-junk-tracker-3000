require 'rails_helper'

RSpec.describe VehiclePart, type: :model do
  subject { build(:vehicle_part) }

  it { is_expected.to belong_to(:vehicle) }
  it { is_expected.to belong_to(:part) }
  it { is_expected.to belong_to(:part_status) }
end
