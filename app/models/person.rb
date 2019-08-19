# frozen_string_literal: true

class Person < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name }

  has_many :directions, dependent: :destroy
  has_many :movies_as_director, through: :directions, source: :movie

  has_many :productions, dependent: :destroy
  has_many :movies_as_producer, through: :productions, source: :movie

  has_many :casts, dependent: :destroy
  has_many :movies_as_member, through: :casts, source: :movie

  def url
    "#{base_url}people/#{id}"
  end
  
  def base_url
    ENV["BASE_URL_API"]
  end
end
