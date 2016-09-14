class Cashier
  def initialize(merchant_processor)
    @merchant_processor = merchant_processor
  end

  def charge(cart, to:)
    raise self.class.empty_cart_error_message if cart.empty?
    raise self.class.invalid_credit_card_error_message unless to.valid?
    @merchant_processor.charge_to(to, price_of(cart))

    record_sales_from_cart(cart)

    cart.destroy!
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

  def self.invalid_credit_card_error_message
    'The credit card is not valid'
  end

  def self.empty_cart_error_message
    'The cart can not be empty'
  end
end