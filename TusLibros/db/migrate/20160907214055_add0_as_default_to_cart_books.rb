class Add0AsDefaultToCartBooks < ActiveRecord::Migration
  def change
      change_column :cart_books, :amount, :integer, :default => 0
  end
end
