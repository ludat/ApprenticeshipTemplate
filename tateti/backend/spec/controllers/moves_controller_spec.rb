require 'rails_helper'

RSpec.describe MovesController, type: :controller do
  context 'with two valid users and a game' do
    let(:user1) { create :lucas }
    let(:user2) { create :roberto }
    let(:game) do
      g = Game.for(user1)
      g.join user2
      g
    end

    context 'the not current player authenticated' do
      before do
        authenticate! user1
      end

      context 'and make the first move' do
        subject do
          post :create, {game_id: game.id, x: 1, y: 1}
        end

        it 'makes the mark' do
          subject

          game.reload
          expect(response).to have_http_status(:forbidden)
          expect(game.current_player).to eq user2
          expect(game.get(Position.center)).to eq nil
        end
      end
    end

    context 'the current player authenticated' do
      before do
        authenticate! user2
      end

      context 'and make the first move' do
        subject do
          post :create, {game_id: game.id, x: 1, y: 1}
        end

        it 'makes the mark' do
          subject

          game.reload
          expect(response).to have_http_status(:created)
          expect(game.current_player).to eq user1
          expect(game.get(Position.center)).to eq user2
        end
      end
    end
  end
end
