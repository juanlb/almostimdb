# frozen_string_literal: true

class Person < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name }

  has_many :directions
  has_many :movies_as_director, through: :directions, source: :movie

  def url
    base_url = ENV("BASE_URL_API")
    "#{base_url}people/#{object.id}"
  end
end
