# frozen_string_literal: true

class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title

  link :self do |object|
    base_url = ENV["BASE_URL_API"]
    "#{base_url}movie/#{object.id}"
  end

  attribute :release_year do |obj|
    RomanNumerals.to_roman(obj.release_year)
  end

  has_many :directors, record_type: :person, serializer: PersonResumedSerializer

end
