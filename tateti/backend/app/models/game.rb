class Game < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :user
  has_one :board

  def self.for(player1, player2)
    Game.create!()
  end

  def mark(position)
    validate_mark(position)

    board.set(position, user)

    self.user = other_player
    save!
  end

  def validate_mark(pos)
    raise TicTacToeException, "That's not a valid position" if board.occupied?(pos)
    raise TicTacToeException, 'The game has already ended' if self.ended?
  end
  def get(position)
    board.get(position)
  end

  def winner
    users.find { |player| self.has_won?(player) }
  end

  def ended?
    board_is_full or any_player_won
  end

  def board_is_full
    Position.all.all? { |pos|
      not board.empty?(pos)
    }
  end

  def any_player_won
    users.any?{ |u| self.has_won?(u) }
  end

  def current_player
    user
  end

  def other_player
    users.all.find { |u| u != user}
  end

  def has_won?(player)
    # if any of the winning groups has its positions marked by the player, the player has won
    Position.win_groups.any? { |positions|
      positions.all? { |pos|
        board.get(pos) == player
      }
    }
  end

  def empty?()
    Position.all.all? {|pos|
      board.empty?(pos)
    }
  end
end
