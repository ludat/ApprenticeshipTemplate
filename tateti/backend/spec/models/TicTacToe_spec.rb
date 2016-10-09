require 'rails_helper'

describe Game do
  let(:user1) { create :lucas}
  let(:user2) { create :roberto }
  let(:game) { create :game, users: [user1, user2], user: user1 }
  it "the board should be empty at the start of the game" do
    expect(game).to be_empty
  end

  context "after the first move" do
    before { game.mark(Position.down) }

    it "shouldn't be is_empty" do
      expect(game).not_to be_empty
    end
    it "mark a position" do
      expect(game.get(Position.down)).to eql user1
    end

    it "shouldn't be able to mark a marked position" do
      expect {game.mark(Position.down)}.to raise_error(TicTacToeException, "That's not a valid position")
    end

  end

  context "One turn from finishing the game" do
    before do
      game.mark(Position.up)
      game.mark(Position.down)
      game.mark(Position.upLeft)
      game.mark(Position.downLeft)
    end

    it "should not end if less than three moves by each player were made" do
      expect(game).not_to be_ended
    end

    it "should NOT be able to tell who won " do
      expect(game.winner).to be_nil
    end

    context "After 'X' player has won" do
      before { game.mark(Position.upRight) }

      it "The game should end" do
        expect(game).to be_ended
      end

      it "should not be able to mark anything" do
        expect{ game.mark(Position.downRight) }.to raise_error(TicTacToeException, 'The game has already ended')
      end

      it "should be able to tell who won " do
        expect(game.winner).to be user1
      end
    end
  end
  context "for a tied game" do
    before do
      game.mark(Position.down)
      game.mark(Position.downLeft)
      game.mark(Position.upLeft)
      game.mark(Position.downRight)
      game.mark(Position.upRight)
      game.mark(Position.center)
      game.mark(Position.left)
      game.mark(Position.up)
      game.mark(Position.right)
    end
    it "should be marked as ended" do
      expect(game.ended?).to eql true
    end
    it "should have no winner" do
      expect(game.winner).to eql nil
    end
  end
end
