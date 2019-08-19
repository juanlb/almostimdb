require 'rails_helper'

RSpec.describe Production, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:production)).to be_valid
    end
  end

  describe 'Presence validations' do
    it { should validate_presence_of(:person) }
    it { should validate_presence_of(:movie) }
  end

  describe 'Uniqueness validations' do
    subject { create(:production) }
    it { should validate_uniqueness_of(:person_id).scoped_to(:movie_id) }
  end
end
