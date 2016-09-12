require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #login' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #login' do
    it 'should set the login variable' do
      lucas = create :lucas
      post :login, username: lucas.username, password: lucas.password
      expect(session[:user_id]).to be lucas.id
    end
  end
end
