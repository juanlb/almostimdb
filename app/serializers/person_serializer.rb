# frozen_string_literal: true

class PersonSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :aliases

  attribute :full_name do |obj|
    aliases = "(#{obj.aliases})" unless obj.aliases.blank?
    "#{obj.first_name} #{obj.last_name} #{aliases}".strip
  end
end