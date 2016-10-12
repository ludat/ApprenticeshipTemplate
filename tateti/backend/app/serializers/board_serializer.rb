class BoardSerializer < ActiveModel::Serializer
  attributes :id
  has_many :moves
end
