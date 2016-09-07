class Book < ActiveRecord::Base
  has_many :carts, through: :carts_books
  has_many :cart_books
end
