# frozen_string_literal: true

FactoryBot.define do
    factory :user do
      email { 'admin@admin.com' }
      password { 'admin@admin.com'}
    end
  end
  