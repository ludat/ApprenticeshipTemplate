class AI
  def get_next_move(the_game)
    myself = the_game.current_player
    opponent = the_game.other_player
    move_value_hash = Hash.new(0)

    # All valid moves
    Position.all.select { |pos|
      the_game.get(pos) == ' '
    }.each { |pos|
      move_value_hash[pos] = 1
    }

    Position.win_groups.each { |positions|
      content = Hash.new(0)
      positions.each { |pos|
        content[the_game.get(pos)] += 1
      }
      if content[opponent] == 2 and content[nil] == 1
        move_value_hash[positions.find { |pos| the_game.get(pos) == nil }] = 5
      end
    }

    Position.win_groups.each { |positions|
      content = Hash.new(0)
      positions.each { |pos|
        content[the_game.get(pos)] += 1
      }
      if content[myself] == 2 and content[nil] == 1
        move_value_hash[positions.find { |pos| the_game.get(pos) == nil }] = 10
      end
    }

    move_value_hash.max_by { |position, value| value }[0]
  end
end
