class SaleSerializer < ActiveModel::Serializer
  attributes :amount
  has_one :book
end
