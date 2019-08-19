# frozen_string_literal: true

class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title

  link :self, :url

  attribute :release_year do |obj|
    RomanNumerals.to_roman(obj.release_year)
  end

  has_many :directors, record_type: :person, serializer: PersonResumedSerializer, links: {
    related: ->(object) {
      "#{object.base_url}movies/#{object.id}/directors"
    }
  }

  has_many :producers, record_type: :person, serializer: PersonResumedSerializer, links: {
    related: ->(object) {
      "#{object.base_url}movies/#{object.id}/producers"
    }
  }

  has_many :casting, record_type: :person, serializer: PersonResumedSerializer, links: {
    related: ->(object) {
      "#{object.base_url}movies/#{object.id}/cast"
    }
  }

end
