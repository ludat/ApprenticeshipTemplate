class Sale < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  def isbn
    book.isbn
  end
end
