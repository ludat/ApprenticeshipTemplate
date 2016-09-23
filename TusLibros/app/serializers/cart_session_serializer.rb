class CartSessionSerializer < ActiveModel::Serializer
  attribute :id
  has_many :cart_books, key: :content
end
