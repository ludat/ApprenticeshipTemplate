class AI
  def get_next_move(the_game)
    myself = the_game.current_player
    opponent = the_game.non_current_player
    moveValueHash = Hash.new(0)

    # All valid moves
    Position.all.select { |pos|
      the_game.get(pos) == ' '
    }.each { |pos|
      moveValueHash[pos] = 1
    }

    Position.win_groups.each { |positions|
      content = Hash.new(0)
      positions.each { |pos|
        content[the_game.get(pos)] += 1
      }
      if content[opponent] == 2 and content[' '] == 1
        moveValueHash[positions.find { |pos| the_game.get(pos) == ' ' }] = 5
      end
    }

    Position.win_groups.each { |positions|
      content = Hash.new(0)
      positions.each { |pos|
        content[the_game.get(pos)] += 1
      }
      if content[myself] == 2 and content[' '] == 1
        moveValueHash[positions.find { |pos| the_game.get(pos) == ' ' }] = 10
      end
    }

    moveValueHash.max_by { |position, value| value }[0]
  end
end
