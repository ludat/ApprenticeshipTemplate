class CreateCartBooks < ActiveRecord::Migration
  def change
    create_table :cart_books do |t|
      t.references :cart
      t.references :book

      t.timestamps null: false
    end
  end
end
