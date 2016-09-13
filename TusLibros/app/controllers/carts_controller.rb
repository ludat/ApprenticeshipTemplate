class CartsController < ApplicationController
  def create
    user = User.find_by(id: params[:clientId], password: params[:password])
    return render json: {error: 'invalid user'}, status: :forbidden if user.nil?

    cart = Cart.create!(user: user)
    render json: cart.as_json(only: [:id]), status: :created
  end

  def show
    cart = Cart.find(params['id'])
    render json: cart.as_json(only: [:id])
  end

  def addBook
    # cartId: Id del carrito creado con /createCart
    # bookIsbn: ISBN del libro que se desea agregar. Debe ser un ISBN de la editorial
    # bookQuantity: Cantidad de libros que se desean agregar. Debe ser >= 1.
    cart = Cart.find(request.params['id'])
    book = Book.find_by_isbn(request.params['bookIsbn'])

    cart.add(book, request.params['bookQuantity'].to_i)

    render nothing: true
  end

  def books
    cart = Cart.find(params['id'])

    render json: cart.cart_books.to_a.map { |o| { 'isbn'=> o.book.isbn, 'amount' => o.amount } }
  end

  def checkout
    cart = Cart.find(params['id'])

    cashier = Cashier.new(MerchantProcessor.new)

    cashier.charge cart, to: nil

    render nothing: true
  end
end
