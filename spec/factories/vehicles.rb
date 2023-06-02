# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle do
    sequence(:nickname) { |n| "Test #{n}" }
    vehicle_type
  end
end
