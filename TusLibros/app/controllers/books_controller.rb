class BooksController < ApplicationController
  def index
    books = Book.all
    render json: books.map { |book| {isbn: book.isbn}}
  end
end
