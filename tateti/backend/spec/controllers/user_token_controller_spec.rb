require 'rails_helper'

RSpec.describe UserTokenController, type: :controller do
  context 'with valid credentials' do
    let(:user) { create(:lucas) }

    subject do
      post :create, username: user.username, password: user.password
    end

    it 'I get a jwt with that user id' do
      subject

      token = json['token']
      content = JwtService.decode(token)
      expect(response).to have_http_status(:created)
      expect(content).to eq({'user' => {'id' => user.id, 'username' => user.username}})
    end
  end
  context 'with a invalid credentials' do

    subject do
      post :create, {username: 'j', password: 'j'}
    end

    it 'I get a jwt with that user id' do
      subject

      expect(response).to have_http_status :unauthorized
      expect(json).to eq({'error' => 'Invalid credentials'})
    end
  end
end
