class AddBoardToMoves < ActiveRecord::Migration
  def change
    add_reference :moves, :board, foreign_key: true
  end
end
