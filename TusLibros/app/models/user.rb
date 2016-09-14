class User < ActiveRecord::Base
  has_many :credit_cards
  has_many :carts
  has_many :sales

  def has_credit_card?
    credit_cards.any?
  end

  def pucharses
    Sale.where(user: self).map { |sale|
      { isbn: sale.book.isbn, amount: sale.amount }
    }
  end
end
