class AddAmountToCartBooks < ActiveRecord::Migration
  def change
    add_column :cart_books, :amount, :integer
  end
end
