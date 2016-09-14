class CartsController < ApplicationController

  before_action :assert_cart_is_active, only: [:show, :add_book, :books, :checkout]

  def create
    user = User.find_by(id: params[:clientId], password: params[:password])
    return render json: {error: 'invalid user'}, status: :forbidden if user.nil?

    cart = CartSession.for(user)
    render json: cart.as_json(only: [:id]), status: :created
  end

  def show
    cart = CartSession.find(params['id'])
    render json: cart.as_json(only: [:id])
  end

  def add_book
    cart = CartSession.find(request.params['id'])
    book = Book.find_by_isbn(request.params['bookIsbn'])

    cart.add(book, request.params['bookQuantity'].to_i)

    render nothing: true
  end

  def books
    cart = CartSession.find(params['id'])

    render json: cart.cart_books.to_a.map { |o| {'isbn' => o.book.isbn, 'amount' => o.amount} }
  end

  def checkout
    cart = CartSession.find(params['id'])
    cashier = Cashier.new(MerchantProcessor.new)
    credit_card = CreditCard.new(
        number: params['ccn'],
        expiration_date: params['cced'],
        # cco: params['cco']
    )

    begin
      cashier.charge cart, to: credit_card
    rescue RuntimeError => e
      render json: {error: e.message}, status: 400
    else
      render json: {}
    end
  end

  private
  def assert_cart_is_active
    if not CartSession.find(params['id']).active?
      render json: {error: self.class.expired_cart_error_message}, status: :unprocessable_entity
    end
  end

  def self.expired_cart_error_message
    'This cart has already expired'
  end
end
