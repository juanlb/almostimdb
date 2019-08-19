# frozen_string_literal: true

class MovieResumedSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title

  link :self do |object|
    base_url = ENV['BASE_URL_API']
    "#{base_url}movie/#{object.id}"
  end
end
