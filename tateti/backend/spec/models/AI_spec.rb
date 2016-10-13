describe 'AI' do
  let(:user1) { create :lucas}
  let(:ai_user) { create :roberto }
  let(:game) { create :game, players: [user1, ai_user], current_player: user1 }
  let(:ai) { AI.new }
  skip 'makes the only valid move' do
    game.mark(Position.down, game.current_player)
    game.mark(Position.downLeft, game.current_player)
    game.mark(Position.upLeft, game.current_player)
    game.mark(Position.downRight, game.current_player)
    game.mark(Position.upRight, game.current_player)
    game.mark(Position.center, game.current_player)
    game.mark(Position.left, game.current_player)
    game.mark(Position.up, game.current_player)
    expect(ai.get_next_move(game)).to eq Position.right
  end
  it 'makes the winning move' do
    game.mark(Position.up, user1)
    game.mark(Position.down, ai_user)
    game.mark(Position.upLeft, user1)
    game.mark(Position.downLeft, ai_user)
    expect(ai.get_next_move(game)).to eq Position.upRight
  end
  skip 'ties againt another computer' do
    9.times do
      game.mark(ai.get_next_move(game), game.current_player)
    end
    expect(game).to be_ended
    expect(game.winner).not_to be_nil
  end
  skip 'makes the only non loosing move' do
    game.mark(Position.downLeft, game.current_player)
    game.mark(Position.center, ai_user)
    game.mark(Position.downRight, user1)
    expect(ai.get_next_move(game)).to eq Position.down
  end
  skip "survives having to force the other player" do
    game.mark(Position.downRight)
    game.mark(Position.center)
    game.mark(Position.upLeft)
    expect(ai.get_next_move(game)).to be_one_of [ Position.up, Position.down, Position.left, Position.right ]
  end
  skip 'survives againt a border' do
    game.mark(Position.upLeft)
    expect(ai.get_next_move(game)).to eq Position.center
  end
  skip "survives having to block ahead of time" do
    game.mark(Position.center)
    game.mark(Position.downLeft)
    game.mark(Position.upRight)
    expect(ai.get_next_move(game)).to be_one_of [ Position.upLeft, Position.downRight ]
  end
  # it "survives against center first" do
  #   game.mark(Position.center)
  #   expect(ai.get_next_move(game)).to be_one_of [ Position.upLeft, Position.upRight, Position.downRight, Position.downLeft ]
  # end
end
#    |   |
# ---+---+---
#    |   |
# ---+---+---
#    |   |
