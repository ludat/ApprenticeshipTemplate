class Board

  def initialize(board = nil)
    @board = board || [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' '],
    ]
  end

  def get(pos)
    @board[pos.x][pos.y]
  end

  def empty?(pos)
    @board[pos.x][pos.y] == ' '
  end

  def set(pos, mark)
    @board[pos.x][pos.y] = mark
  end

  def to_s
%{
 #{get(Position.upLeft)} | #{get(Position.up)} | #{get(Position.upRight)}
-----------
 #{get(Position.left)} | #{get(Position.center)} | #{get(Position.right)}
-----------
 #{get(Position.downLeft)} | #{get(Position.down)} | #{get(Position.downRight)}
}
  end

  def clone
    Board.new(@board.map { |row| row.dup })
  end

end
