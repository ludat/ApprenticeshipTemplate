class MovesController < ApplicationController
  def create
    user = User.find(token['user']['id'])
    game = Game.find(params.require(:id))
    position = Position.new(params.require(:x), params.require(:y))

    game.mark(position)

    render json: game, status: :created
  end
end
