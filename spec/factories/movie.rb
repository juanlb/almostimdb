# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title        { Faker::App.name }
    release_year { Faker::Number.between(from: 1930, to: 2019) }
  end
end
