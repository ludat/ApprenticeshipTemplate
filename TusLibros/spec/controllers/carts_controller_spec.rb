require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  describe 'GET #list' do
    let(:lucas) { create :lucas}
    let(:a_cart) { create :cart}

    it 'returns http success' do
      session[:user_id] = a_cart.user.id
      get :list
      expect(response).to have_http_status(:success)
      expect(response.body).to be_empty
    end
  end

  describe 'GET #details' do
    skip 'returns http success' do
      a_cart = create(:cart)
      get :details, params: { id: a_cart.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #create' do
    skip 'returns http success' do
      get :create
      expect(response).to have_http_status(:success)
    end
  end
end
