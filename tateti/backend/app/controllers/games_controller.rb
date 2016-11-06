class GamesController < ApplicationController

  include ExceptionHandler
  include AuthorizationHelper

  def create
    user_id = token['user']['id']

    user = User.find(user_id)

    render json: Game.for(user), status: :created
  end

  def join
    user = User.find(token['user']['id'])
    game = Game.find(params.require(:id))
    game.join(user)
    render json: game
  end

  def show
    render json: Game.find(params[:id])
  end

  def index
    render json: Game.all
  end
end
