class GameSerializer < ActiveModel::Serializer
  attributes :id, :state
  has_one :board
  has_many :users, key: :players
  has_one :user, key: :currentPlayer
end
