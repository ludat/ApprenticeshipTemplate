class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :x
      t.integer :y

      t.timestamps null: false
    end
  end
end
