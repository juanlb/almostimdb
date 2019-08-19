# frozen_string_literal: true

class PersonSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :aliases

  link :self do |object|
    base_url = ENV["BASE_URL_API"]
    "#{base_url}people/#{object.id}"
  end

  attribute :full_name do |obj|
    aliases = "(#{obj.aliases})" unless obj.aliases.blank?
    "#{obj.first_name} #{obj.last_name} #{aliases}".strip
  end

  has_many :movies_as_director, record_type: :movie, serializer: MovieResumedSerializer
end