class AddGameRefToBoards < ActiveRecord::Migration
  def change
    add_reference :boards, :game, index: true, foreign_key: true
  end
end
