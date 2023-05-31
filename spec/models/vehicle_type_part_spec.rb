require 'rails_helper'

RSpec.describe VehicleTypePart, type: :model do
  subject { build(:vehicle_type_part) }

  it { is_expected.to belong_to(:vehicle_type) }
  it { is_expected.to belong_to(:part) }
  it { is_expected.to belong_to(:part_status) }
end
