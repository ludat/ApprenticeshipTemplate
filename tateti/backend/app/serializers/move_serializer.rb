class MoveSerializer < ActiveModel::Serializer
  attributes :x, :y
  has_one :user, key: :player
end
