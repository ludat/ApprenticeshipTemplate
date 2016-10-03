class Game < ActiveRecord::Base

  has_one :board
  has_many :players
  has_one :player

  def initialize(player1 = 'X', player2 = 'O', board = nil)
    @players = [player1, player2]
    @board = board || Board.new
  end

  def clone
    Game.new(@players.first, @players[1], @board.clone)
  end

  def mark(pos)
    validate_mark(pos)
    @board.set(pos, current_player)
    @players.rotate!
  end

  def validate_mark(pos)
    raise TicTacToeException, "That's not a valid position" if not @board.empty?(pos)
    raise TicTacToeException, "The game has already ended" if self.ended?
  end
  def get(pos)
    @board.get(pos)
  end

  def winner
    @players.find { |player| self.has_won(player) }
  end

  def ended?
    board_is_full or any_player_won
  end

  def board_is_full
    Position.all.all? { |pos|
      not @board.empty?(pos)
    }
  end

  def any_player_won
    @players.any?{ |player| self.has_won(player) }
  end

  def current_player
    @players.first
  end

  def non_current_player
    @players[1]
  end

  def has_won(player)
    # if any of the winning groups has its positions marked by the player, the player has won
    Position.win_groups.any? { |positions|
      positions.all? { |pos|
        @board.get(pos) == player
      }
    }
  end

  def empty?()
    Position.all.all? {|pos|
      @board.empty?(pos)
    }
  end
end
