class GameSerializer < ActiveModel::Serializer
  attributes :id, :state
  has_one :board
  has_many :users, as: :players
end
