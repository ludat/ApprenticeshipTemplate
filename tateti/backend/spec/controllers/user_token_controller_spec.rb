require 'rails_helper'

RSpec.describe UserTokenController, type: :controller do
  context 'with a valid user and a valid password' do
    it 'I get a jwt with that user id' do
      post :create, { auth: { id: 1, password: 'password'}}
      token = JSON.parse(response.body)['token']
      content = JWT.decode(token, nil, false).first
      expect(content).to eq({'user' => {'id' => 1}})
    end
  end
end
