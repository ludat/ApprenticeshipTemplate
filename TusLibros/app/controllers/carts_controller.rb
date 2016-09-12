class CartsController < ApplicationController
  def show
    cart = Cart.find(request.params['id'])
    render template: 'carts/show', locals: {cart: cart}
  end

  def get_add_book
    books = Book.all
    cart = Cart.find(request.params['id'])
    render template: 'carts/add_book', locals: { books: books, cart: cart }
  end

  def add_book
    # cartId: Id del carrito creado con /createCart
    # bookIsbn: ISBN del libro que se desea agregar. Debe ser un ISBN de la editorial
    # bookQuantity: Cantidad de libros que se desean agregar. Debe ser >= 1.
    cart = Cart.find(request.params['cart_id'])
    book = Book.find_by_icbn(request.params['book_icbn'])

    cart.add(book, request.params['book_quantity'].to_i)

    get_add_book
  end

  def list
    carts = User.find(session[:user_id]).carts
    render template: 'carts/list', locals: {carts: carts}
  end

  def create
    cart = Cart.create!(user_id: session[:user_id])
    redirect_to "/carts/#{cart.id}"
  end
end
