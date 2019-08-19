# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:movie)).to be_valid
    end
  end

  describe 'Presence validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:release_year) }
  end

  describe 'Uniqueness validations' do
    subject { build(:movie) }
    it { should validate_uniqueness_of(:title).scoped_to(:release_year) }
  end
end
