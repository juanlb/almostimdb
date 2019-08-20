# frozen_string_literal: true

class PersonSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :aliases, :full_name

  link :self, :url

  has_many :movies_as_director, record_type: :movie, serializer: MovieResumedSerializer
  has_many :movies_as_producer, record_type: :movie, serializer: MovieResumedSerializer
  has_many :movies_as_member, record_type: :movie, serializer: MovieResumedSerializer
end
