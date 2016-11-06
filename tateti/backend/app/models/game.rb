class Game < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :user
  has_one :board

  alias_attribute :current_player, :user
  alias_attribute :players, :users

  def self.for(*users)
    Game.create!(players: users, board: Board.create!)
  end

  def mark(position, player)
    validate_mark(position)
    raise NotYourTurnException, 'It is not your turn' if player != current_player

    board.set(position, current_player)

    self.current_player = other_player
    save!
  end

  def validate_mark(position)
    raise InvalidPositionException, "That's not a valid position" if board.occupied?(position)
    raise EndedException, 'The game has already ended' if self.ended?
  end

  def get(position)
    board.get(position)
  end

  def winner
    players.find { |player| self.has_won?(player) }
  end

  def ended?
    board_is_full or any_player_won
  end

  def board_is_full
    Position.all.all? { |pos|
      not board.empty_position?(pos)
    }
  end

  def any_player_won
    players.any? { |u| self.has_won?(u) }
  end

  def has_won?(player)
    # if any of the winning groups has its positions marked by the player, the player has won
    Position.win_groups.any? { |positions|
      positions.all? { |pos|
        board.get(pos) == player
      }
    }
  end

  def join(player)
    raise TicTacToeException, 'This board is already full' if players.count == 2
    raise TicTacToeException, 'You can not play with yourself' if players.exists? player.id

    players.push(player)

    if players.count == 2
      self.user = player
    end

    save!
  end

  def state
    'waiting'
  end

  def empty?
    Position.all.all? { |pos|
      board.empty_position?(pos)
    }
  end

  def other_player
    players.all.find { |player| player != current_player }
  end

  class NotYourTurnException < Exception
  end

  class InvalidPositionException < Exception
  end

  class EndedException < Exception
  end
end
