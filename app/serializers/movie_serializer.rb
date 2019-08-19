# frozen_string_literal: true

class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title

  attribute :release_year do |obj|
    RomanNumerals.to_roman(obj.release_year)
  end
end
