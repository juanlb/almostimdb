require 'rails_helper'

RSpec.describe Direction, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:direction)).to be_valid
    end
  end

  describe 'Presence validations' do
    it { should validate_presence_of(:person) }
    it { should validate_presence_of(:movie) }
  end

  describe 'Uniqueness validations' do
    subject { create(:direction) }
    it { should validate_uniqueness_of(:person_id).scoped_to(:movie_id) }
  end

end
