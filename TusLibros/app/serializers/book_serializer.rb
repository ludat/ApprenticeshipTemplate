class BookSerializer < ActiveModel::Serializer
  attributes :isbn, :price, :title
end
