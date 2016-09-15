class CartsController < ApplicationController

  around_action :handle_exception

  def handle_exception
    begin
      yield
    rescue ActionController::ParameterMissing => e
      render json: {error: e.message}, status: :bad_request
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
    user = User.login(**user_credentials_params)

    cart = CartSession.for(user)
    render json: cart.as_json(only: [:id]), status: :created
  end

  def user_credentials_params
    {id: params.require(:clientId), password: params.require(:password) }
  end

  def show
    cart = CartSession.find(params.require(:id))
    render json: cart.as_json(only: [:id])
  end

  def add_book
    cart = CartSession.find(params.require(:id))
    book = Book.find_by_isbn(params.require(:bookIsbn))

    cart.add(book, params.require(:bookQuantity).to_i)

    render nothing: true
  end

  def books
    cart = CartSession.find(params.require(:id))

    render json: cart.cart_books.to_a.map { |o| {'isbn' => o.book.isbn, 'amount' => o.amount} }
  end

  def checkout
    cart = CartSession.find(params.require(:id))
    cashier = Cashier.new(MerchantProcessor.new)
    credit_card = CreditCard.new(
        user: cart.user,
        number: params.require(:ccn),
        expiration_date: params.require(:cced),
        # cco: params['cco']
    )

    cashier.charge cart, to: credit_card
    render json: {}
  end
end
