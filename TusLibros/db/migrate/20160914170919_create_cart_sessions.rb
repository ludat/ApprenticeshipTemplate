class CreateCartSessions < ActiveRecord::Migration
  def change
    create_table :cart_sessions do |t|
      t.references :cart, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
