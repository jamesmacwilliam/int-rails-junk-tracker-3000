FactoryBot.define do
  factory :vehicle_type do
    sequence(:name) { |n|  "Type #{n}" }
    has_doors { true }
    has_sliding_doors { false }
    door_count { 2 }
  end
end
