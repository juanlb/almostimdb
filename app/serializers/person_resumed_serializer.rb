# frozen_string_literal: true

class PersonResumedSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :aliases

  link :self do |object|
    base_url = ENV['BASE_URL_API']
    "#{base_url}people/#{object.id}"
  end
end
