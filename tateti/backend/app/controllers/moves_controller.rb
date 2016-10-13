class MovesController < ApplicationController

  include ExceptionHandler
  include AuthorizationHelper

  def create
    user = User.find(token['user']['id'])
    game = Game.find(params.require(:game_id))
    position = Position.new(params.require(:x), params.require(:y))

    game.mark(position, user)

    render json: game, status: :created
  end
end
