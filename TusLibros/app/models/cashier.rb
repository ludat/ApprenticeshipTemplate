class Cashier
  def initialize(merchant_processor)
    @merchant_processor = merchant_processor
  end

  def charge(cart, to:)
    raise self.class.empty_cart_error_message if cart.empty?
    @merchant_processor.charge_to(to, price_of(cart))
  end

  def price_of(cart)
    cart.cart_books.map { |order| order.book.price * order.amount }.reduce(0, :+)
  end

  def self.empty_cart_error_message
    "The cart can't be empty"
  end
end