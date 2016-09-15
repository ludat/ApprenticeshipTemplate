class CartSession < ActiveRecord::Base
  belongs_to :cart
  belongs_to :user

  before_create :update_last_operated_at

  def update_last_operated_at
    self.last_operated_at = Time.now
  end

  def self.for(a_user)
    CartSession.create!(user: a_user, cart: Cart.create)
  end

  def active?
    Time.now - last_operated_at < 30.minutes
  end

  def add(a_book, amount)
    assert_active_session
    cart.add(a_book, amount)
  end

  def empty?
    assert_active_session
    cart.empty?
  end

  def assert_active_session
    raise ExpiredException, self.class.expired_cart_error_message unless active?
  end

  class ExpiredException < Exception;
  end

  def self.expired_cart_error_message
    'The cart has expired'
  end

  def include?(a_book)
    assert_active_session
    cart.include? a_book
  end

  def occurrences_of(a_book)
    assert_active_session
    cart.occurrences_of a_book
  end

  def cart_books
    assert_active_session
    cart.cart_books
  end
end
