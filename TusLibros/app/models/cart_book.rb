class CartBook < ActiveRecord::Base
  belongs_to :cart
  belongs_to :book

  validates :amount, numericality: {greater_than: 0}

  delegate :isbn, :price, :title, to: :book
end
