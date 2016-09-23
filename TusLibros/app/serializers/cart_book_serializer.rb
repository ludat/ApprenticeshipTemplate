class CartBookSerializer < ActiveModel::Serializer
  attributes :amount, :title, :isbn, :price
end
