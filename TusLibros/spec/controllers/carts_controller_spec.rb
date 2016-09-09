require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  describe 'GET #list' do
    let(:a_cart) { create(:cart)}

    it 'returns http success' do
      get :list, as: json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #details' do
    it 'returns http success' do
      get :details
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #create' do
    it 'returns http success' do
      get :create
      expect(response).to have_http_status(:success)
    end
  end
end
