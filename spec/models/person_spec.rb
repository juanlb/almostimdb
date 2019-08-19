# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:person)).to be_valid
    end
  end

  describe 'Presence validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'Uniqueness validations' do
    subject { build(:person) }
    it { should validate_uniqueness_of(:first_name).scoped_to(:last_name) }
  end
end
