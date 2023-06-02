FactoryBot.define do
  factory :vehicle_type do
    sequence(:name) { |n|  "Type #{n}" }
    door_count { 2 }
  end
end
