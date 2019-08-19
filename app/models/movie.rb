# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, :release_year, presence: true
  validates :title, uniqueness: { scope: :release_year }
end
