class CreateJoinTableUserGame < ActiveRecord::Migration
  def change
    create_join_table :users, :games
  end
end
