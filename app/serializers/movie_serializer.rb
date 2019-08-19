# frozen_string_literal: true

class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title

  link :self, :url

  attribute :release_year do |obj|
    RomanNumerals.to_roman(obj.release_year)
  end

  has_many :directors, record_type: :person, serializer: PersonResumedSerializer
  has_many :producers, record_type: :person, serializer: PersonResumedSerializer
  has_many :casting, record_type: :person, serializer: PersonResumedSerializer

end
