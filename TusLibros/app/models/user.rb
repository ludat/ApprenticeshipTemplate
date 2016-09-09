class User < ActiveRecord::Base
  has_many :credit_cards
  has_many :carts

  def has_credit_card?
    credit_cards.any?
  end
end
