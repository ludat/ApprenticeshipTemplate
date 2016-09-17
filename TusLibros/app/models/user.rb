class User < ActiveRecord::Base
  has_many :credit_cards
  has_many :carts
  has_many :sales

  def self.login(id:, password:)
    user = User.find_by(id: id, password: password)
    raise BadCredentialsException, self.user_credentials_invalid_error_message if user.nil?
    user
  end

  def self.user_credentials_invalid_error_message
    'Invalid credentials'
  end

  class BadCredentialsException < Exception
  end

  def has_credit_card?
    credit_cards.any?
  end

  def pucharses
    Sale.where(user: self)
  end
end
