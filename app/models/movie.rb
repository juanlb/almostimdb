# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, :release_year, presence: true
  validates :title, uniqueness: { scope: :release_year }

  has_many :directions
  has_many :directors, through: :directions, source: :person

  has_many :productions
  has_many :producers, through: :productions, source: :person

  has_many :casts
  has_many :casting, through: :casts, source: :person

  def url
    base_url = ENV['BASE_URL_API']
    "#{base_url}movie/#{id}"
  end
end
