FactoryBot.define do
  factory :part do
    sequence(:name) { |n| "Part #{n}" }
    
  end
end
