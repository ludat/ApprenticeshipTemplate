describe'AI' do
  let(:user1) { create :lucas}
  let(:user2) { create :roberto }
  let(:game) { create :game, users: [user1, user2], user: user1 }
  let(:ai) { AI.new }
  it 'makes the only valid move' do
    game.mark(Position.down)
    game.mark(Position.downLeft)
    game.mark(Position.upLeft)
    game.mark(Position.downRight)
    game.mark(Position.upRight)
    game.mark(Position.center)
    game.mark(Position.left)
    game.mark(Position.up)
    expect(ai.get_next_move(game)).to eq Position.right
  end
  it 'makes the winning move' do
    game.mark(Position.up)
    game.mark(Position.down)
    game.mark(Position.upLeft)
    game.mark(Position.downLeft)
    expect(ai.get_next_move(game)).to eq Position.upRight
  end
  it 'ties againt another computer' do
    9.times do
      game.mark(ai.get_next_move(game))
    end
    expect(game.ended?).to eq true
    expect(game.winner).to eq nil
  end
  it 'makes the only non loosing move' do
    game.mark(Position.downLeft)
    game.mark(Position.center)
    game.mark(Position.downRight)
    expect(ai.get_next_move(game)).to eq Position.down
  end
  it "survives having to force the other player" do
    game.mark(Position.downRight)
    game.mark(Position.center)
    game.mark(Position.upLeft)
    expect(ai.get_next_move(game)).to be_one_of [ Position.up, Position.down, Position.left, Position.right ]
  end
  it 'survives againt a border' do
    game.mark(Position.upLeft)
    expect(ai.get_next_move(game)).to eq Position.center
  end
  it "survives having to block ahead of time" do
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
