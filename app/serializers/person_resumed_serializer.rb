# frozen_string_literal: true

class PersonResumedSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :aliases
  set_type :person

  link :self, :url
end
