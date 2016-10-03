class Position

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other)
    other.class == self.class and other.x == @x and other.y == @y
  end

  alias eql? ==

  def hash
    @x.hash ^ @y.hash # XOR
  end

  def to_s
    "x: #{@x}, y: #{@y}"
  end

  attr_reader :x, :y

  def self.win_groups
    [
        Position.first_diagonal,
        Position.second_diagonal
    ] +
    Position.first_diagonal.map {|pos| pos.all_horizontally } +
    Position.first_diagonal.map {|pos| pos.all_vertically }
  end

  def self.center
    Position.new(1, 1)
  end
  def self.up
    Position.center.up
  end
  def self.down
    Position.center.down
  end
  def self.right
    Position.center.right
  end
  def self.left
    Position.center.left
  end

  def self.upLeft
    Position.center.up.left
  end
  def self.upRight
    Position.center.up.right
  end
  def self.downLeft
    Position.center.down.left
  end
  def self.downRight
    Position.center.down.right
  end
  def diagonal?
    @x % 2 and @y % 2
  end

  def center?
    @x == 1 or @y == 1
  end

  def self.all
    [
      Position.center,
      Position.up,
      Position.down,
      Position.right,
      Position.left,
      Position.upLeft,
      Position.upRight,
      Position.downLeft,
      Position.downRight,
    ]
  end
  def self.first_diagonal
    [
      Position.center,
      Position.upLeft,
      Position.downRight,
    ]
  end
  def self.second_diagonal
    [
      Position.center,
      Position.downLeft,
      Position.upRight,
    ]
  end

  def up
    Position.new(@x, @y + 1)
  end
  def down
    Position.new(@x, @y - 1)
  end
  def right
    Position.new(@x + 1, @y)
  end
  def left
    Position.new(@x - 1, @y)
  end
  def all_horizontally
    [
      Position.new(0, @y),
      Position.new(1, @y),
      Position.new(2, @y),
    ]
  end
  def all_vertically
    [
      Position.new(@x, 0),
      Position.new(@x, 1),
      Position.new(@x, 2),
    ]
  end
  def to_s
    first = 'left' if @x == 0
    first = '' if @x == 1
    first = 'right' if @x == 2
    second = 'down' if @y == 0
    second = '' if @y == 1
    second = 'up' if @y == 2
    if first + second == ''
      'center'
    else
      first + second
    end
  end
end
