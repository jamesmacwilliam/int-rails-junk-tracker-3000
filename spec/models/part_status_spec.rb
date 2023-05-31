require 'rails_helper'

RSpec.describe PartStatus, type: :model do
  subject { build(:part_status) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
end
