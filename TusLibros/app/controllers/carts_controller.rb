class CartsController < ApplicationController

  around_action :handle_exception

  def handle_exception
    begin
      yield
    rescue ActiveRecord::RecordNotFound => e
      render json: {error: e.message}, status: :not_found
    rescue User::BadCredentialsException => e
      render json: {error: e.message}, status: :unauthorized
    rescue Cashier::CartEmptyException => e
      render json: {error: e.message}, status: :bad_request
    rescue CartSession::ExpiredException => e
      render json: {error: e.message}, status: :unprocessable_entity
    rescue ActiveRecord::RecordInvalid => e
      render json: {error: e.message}, status: :bad_request
    end
  end

  def create
    user = User.login(id: params[:clientId], password: params[:password])

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
        user: cart.user,
        number: params['ccn'],
        expiration_date: params['cced'],
        # cco: params['cco']
    )

    cashier.charge cart, to: credit_card
    render json: {}
  end
end
