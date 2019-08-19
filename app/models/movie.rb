# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, :release_year, presence: true
  validates :title, uniqueness: { scope: :release_year }

  has_many :directions, dependent: :destroy
  has_many :directors, through: :directions, source: :person

  has_many :productions, dependent: :destroy
  has_many :producers, through: :productions, source: :person

  has_many :casts, dependent: :destroy
  has_many :casting, through: :casts, source: :person

  def url
    "#{base_url}movies/#{id}"
  end

  def base_url
    ENV['BASE_URL_API']
  end
end
