require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  context 'with a valid user' do
    let(:user) { create :lucas }

    before do
      authenticate! user
    end

    it 'can create a new game' do
      post :create
      expect(response).to have_http_status(:created)
      expect(Game.count).to be 1
      game = Game.first
      expect(json)
          .to eq({
                     'id' => game.id,
                     'state' => 'waiting',
                     'board' => {
                         'id' => 1,
                         'moves' => []
                     },
                     'players' => [
                         {
                             'id' => 1,
                             'username' => "lucas"
                         }
                     ],
                     'currentPlayer' => nil
                 })
    end

    context 'after createing a game' do
      let!(:game) { Game.for(user) }

      it 'returns the board serialized' do
        get :show, {id: game.id}

        expect(response).to have_http_status(:ok)
        expect(json)
            .to eq({
                       'id' => game.id,
                       'state' => 'waiting',
                       'board' => {
                           'id' => game.board.id,
                           'moves' => []
                       },
                       'players' => [
                           {
                               'id' => 1,
                               'username' => "lucas"
                           }
                       ],
                       'currentPlayer' => nil
                   })
      end

      it 'can not join the same board twice' do
        post :join, {id: game.id}

        expect(response).to have_http_status(:bad_request)

        expect(game.users.count).not_to eq 2
        expect(game.current_player).to be_nil
      end

      context 'with another player' do
        let(:user2) { create :roberto }

        before do
          authenticate! user2

          post :join, {id: game.id}
        end

        it 'can join a current game' do
          expect(response).to have_http_status(:ok)

          game.reload
          expect(game.users.count).to eq 2
          expect(game.current_player).to eq user2
        end
      end
    end

    context 'with no games created' do
      subject do
        get :index
      end

      it 'can list them to play one' do
        subject

        expect(json).to eq([])
      end
    end

    context 'with some other games created' do
      let(:user1) { create :roberto }
      let(:user2) { create :juan }
      let(:user3) { create :user, username: 'damian' }

      before do
        Game.for(user)
        Game.for(user1)
        g = Game.for(user2)
        g.join user3
      end

      subject do
        get :index
      end

      it 'can list them to play one' do
        subject

        expect(json).to have_attributes(size: 3)
      end
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
