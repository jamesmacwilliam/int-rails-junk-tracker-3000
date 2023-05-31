require 'rails_helper'

RSpec.describe Door, type: :model do
  subject { build(:door) }

  it { is_expected.to belong_to(:vehicle) }
end
