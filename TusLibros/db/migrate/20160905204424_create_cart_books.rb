class CreateCartBooks < ActiveRecord::Migration
  def change
    create_table :cart_books do |t|
      t.references :cart, null: false
      t.references :book, null: false
      t.integer :amount, null: false, default: 0

      t.timestamps null: false
    end
  end
end
