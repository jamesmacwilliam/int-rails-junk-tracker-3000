# frozen_string_literal: true

FactoryBot.define do
  factory :part_status do
    sequence(:name) { |n| "Part #{n}" }
  end
end
