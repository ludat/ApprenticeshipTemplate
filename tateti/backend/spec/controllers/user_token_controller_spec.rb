require 'rails_helper'

RSpec.describe UserTokenController, type: :controller do
  context 'with a valid user and a valid password' do
    let(:user) { create(:lucas) }

    before do
      post :create, { id: user.username }
    end

    it 'I get a jwt with that user id' do
      expect(response).to have_http_status(:created)
      token = JSON.parse(response.body)['token']
      content = JWT.decode(token, nil, false).first
      expect(content).to eq({'user' => {'id' => user.id, 'username' => user.username}})
    end
  end
  context 'with an invalid user and a valid password' do
    before do
      post :create, { id: 153 }
    end

    it 'I get a jwt with that user id' do
      expect(response).to have_http_status :unauthorized
      expect(JSON.parse(response.body))
          .to eq({'error' => 'Invalid credentials'})
    end
  end
end
