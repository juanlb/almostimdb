# frozen_string_literal: true

class MovieResumedSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title
  set_type :movie

  link :self, :url
end
