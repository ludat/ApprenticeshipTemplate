class Cashier
  def initialize(merchant_processor)
    @merchant_processor = merchant_processor
  end

  def charge(cart, to:)
    assert_cart_is_not_empty(cart)
    to.save!

    @merchant_processor.charge_to(to, price_of(cart))

    record_sales_from_cart(cart)

    cart.destroy!
  end

  def assert_cart_is_not_empty(cart)
    raise EmptyCartException, self.class.empty_cart_error_message if cart.empty?
  end


  def record_sales_from_cart(cart)
    cart.cart_books.each { |order|
      Sale.create!(user: cart.user, book: order.book, amount: order.amount)
      order.destroy!
    }
  end

  def price_of(cart)
    cart.cart_books.map { |order| order.book.price * order.amount }.reduce(0, :+)
  end

  class EmptyCartException < Exception
  end

  def self.invalid_credit_card_error_message
    'The credit card is not valid'
  end

  def self.empty_cart_error_message
    'The cart can not be empty'
  end
end