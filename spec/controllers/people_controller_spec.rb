require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  login_user

  let(:valid_attributes) do
    { first_name: 'Silvester', last_name: 'Stallone', aliases: 'Rambo' }
  end

  let(:invalid_attributes) do
    { first_name: 'Silvester', last_name: nil}
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    let!(:person) { create(:person) }
    it 'redirects to the people list' do
      delete :destroy, params: { id: person.to_param }
      expect(response).to redirect_to(people_url)
    end
  end

  describe 'PUT #update' do
    context 'valid parameters' do
      let!(:person) { create(:person) }
      it 'returns http success' do
        put :update, params: { id: person.to_param, person: valid_attributes }
        expect(response).to redirect_to(person)
      end
    end
    context 'invalid parameters' do
      let!(:person) { create(:person) }
      it 'returns http success' do
        put :update, params: { id: person.to_param, person: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'valid parameters' do
      it 'returns http success' do
        post :create, params: { person: valid_attributes }
        expect(response).to redirect_to(Person.last)
      end
    end
    context 'invalid parameters' do
      it 'returns http success' do
        post :create, params: {  person: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
