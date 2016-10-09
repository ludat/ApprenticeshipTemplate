require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:user2) { create :roberto }

  context 'with a valid user' do
    let(:user1) { create :lucas }

    it 'can create a new game' do
      post :create
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq({'id' => 1})
    end
  end

end
