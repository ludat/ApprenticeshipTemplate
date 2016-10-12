class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :board, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
