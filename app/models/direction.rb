# frozen_string_literal: true

class Direction < ApplicationRecord
  belongs_to :person
  belongs_to :movie

  validates :person, :movie, presence: true
  validates :person_id, uniqueness: { scope: :movie_id }

end
