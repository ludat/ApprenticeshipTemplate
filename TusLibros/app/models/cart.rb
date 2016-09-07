class Cart < ActiveRecord::Base
  has_many :books, through: :cart_books
  has_many :cart_books

  def add(a_book, amount)
    order = CartBook.find_or_create_by!(cart: self, book: a_book)
    order.amount += amount
    order.save
  end

  def empty?
    self.books.empty?
  end

  def include?(a_book)
    self.books.include? a_book
  end

  def occurrences_of(a_book)
    # TODO high evilness warning, I'd love to have the maybe monad but all I have is the list monad
    self.cart_books.select { |order| order.book == a_book }.reduce(0) {|_, order| order.amount }
  end
end
