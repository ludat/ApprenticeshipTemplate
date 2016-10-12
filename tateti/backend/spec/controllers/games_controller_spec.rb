require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  context 'with a valid user' do
    let(:user1) { create :lucas }

    before do
      authenticate! user1
    end

    it 'can create a new game' do
      post :create
      expect(response).to have_http_status(:created)
    end
  end
  context 'without a valid user' do
    it 'can not create a board' do
      post :create
      expect(response).to have_http_status(:unauthorized)
      expect(Game.count).to be 0
    end
  end
end
