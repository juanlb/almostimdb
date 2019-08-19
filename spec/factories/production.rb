# frozen_string_literal: true

FactoryBot.define do
  factory :production do
    association :person
    association :movie
  end
end
