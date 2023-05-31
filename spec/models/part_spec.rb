require 'rails_helper'

RSpec.describe Part, type: :model do
  subject { build(:part) }

  it { is_expected.to validate_presence_of(:name) }
end
