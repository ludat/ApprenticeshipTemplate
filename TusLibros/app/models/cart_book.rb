class CartBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :cart

  def isbn
    book.isbn
  end

  validates :amount, numericality: {greater_than: 0}
end
