require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:user1) { create :lucas}
  let(:user2) { create :roberto }
  let(:game) { create :game, users: [user1, user2], user: user1 }
  it "the board should be empty at the start of the game" do
    expect(game).to be_empty
  end

  context "after the first move" do
    before { game.mark(Position.down, user1) }

    it "shouldn't be is_empty" do
      expect(game).not_to be_empty
    end
    it "mark a position" do
      expect(game.get(Position.down)).to eql user1
    end

    it "shouldn't be able to mark a marked position" do
      expect {game.mark(Position.down, user1)}.to raise_error Game::InvalidPositionException
    end

  end

  context "One turn from finishing the game" do
    before do
      game.mark(Position.up, user1)
      game.mark(Position.down, user2)
      game.mark(Position.upLeft, user1)
      game.mark(Position.downLeft, user2)
    end

    it "should not end if less than three moves by each player were made" do
      expect(game).not_to be_ended
    end

    it "should NOT be able to tell who won " do
      expect(game.winner).to be_nil
    end

    context "After 'X' player has won" do
      before { game.mark(Position.upRight, user1) }

      it "The game should end" do
        expect(game).to be_ended
      end

      it "should not be able to mark anything" do
        expect{ game.mark(Position.downRight, game.current_player) }.to raise_error Game::EndedException
      end

      it "should be able to tell who won " do
        expect(game.winner).to be user1
      end
    end
  end
  context "for a tied game" do
    before do
      game.mark(Position.down, user1)
      game.mark(Position.downLeft, user2)
      game.mark(Position.upLeft, user1)
      game.mark(Position.downRight, user2)
      game.mark(Position.upRight, user1)
      game.mark(Position.center, user2)
      game.mark(Position.left, user1)
      game.mark(Position.up, user2)
      game.mark(Position.right, user1)
    end
    it "should be marked as ended" do
      expect(game.ended?).to eql true
    end
    it "should have no winner" do
      expect(game.winner).to eql nil
    end
  end
end
