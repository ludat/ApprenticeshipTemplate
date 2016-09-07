class BooksController < ApplicationController

  def show
    @books = Book.all
    render 'all'
  end
  def new
  end
end
