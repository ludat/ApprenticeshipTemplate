class CartsController < ApplicationController
  def show
    @cart = Cart.find request.params['id']
  end

  def list
    @carts = Cart.all
  end

  def create
    cart = Cart.create
    redirect_to "/carts/#{cart.id}"
  end
end
