# frozen_string_literal: true

FactoryBot.define do
    factory :cast do
      association :person
      association :movie
    end
  end
  