class CartsController < ApplicationController

  include CartControllerExceptionHandler

  def create
    user = User.login(**user_credentials_params)

    cart = CartSession.for(user)
    render json: cart, status: :created
  end

  def user_credentials_params
    {id: params.require(:clientId), password: params.require(:password) }
  end

  def show
    cart = CartSession.find(params.require(:id))
    render json: cart
  end

  def add_book
    cart = CartSession.find(params.require(:id))
    book = Book.find_by_isbn!(params.require(:isbn))

    cart.add(book, params.require(:amount).to_i)

    render nothing: true
  end

  def books
    cart = CartSession.find(params.require(:id))

    render json: cart.cart_books
  end

  def checkout
    cart = CartSession.find(params.require(:id))
    cashier = Cashier.new(MerchantProcessor.new)
    credit_card = CreditCard.new(
        user: cart.user,
        number: params.require(:ccn),
        expiration_date: Date.parse(params.require :cced),
        # cco: params['cco']
    )

    cashier.charge cart, to: credit_card
    render json: {}
  end
end
