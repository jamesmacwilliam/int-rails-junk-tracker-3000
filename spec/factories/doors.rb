# frozen_string_literal: true

FactoryBot.define do
  factory :door do
    vehicle
    is_sliding { false }
  end
end
