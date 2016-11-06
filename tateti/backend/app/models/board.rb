class Board < ActiveRecord::Base
  has_many :moves
  belongs_to :game

  def get(position)
    move = moves.find_by(x: position.x, y: position.y)

    if move.nil?
      nil
    else
      move.user
    end
  end

  def occupied?(position)
    moves.exists?(x: position.x, y: position.y)
  end

  def empty_position?(position)
    not occupied?(position)
  end

  def set(pos, user)
    moves.create!(x: pos.x, y: pos.y, user: user)
  end
end
