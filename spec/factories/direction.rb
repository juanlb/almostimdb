# frozen_string_literal: true

FactoryBot.define do
  factory :direction do
    association :person
    association :movie
  end
end
