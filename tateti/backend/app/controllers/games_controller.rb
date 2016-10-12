class GamesController < ApplicationController

  include ExceptionHandler

  def create
    user_id = token['user']['id']

    user = User.find(user_id)

    render json: Game.for(user), status: :created
  end

  def show
    render json: Game.find(params[:id])
  end

  def encode(json)
    JWT.encode(json, nil, 'none')
  end

  def decode(token)
    JWT.decode(token, nil, false).first
  end

  def token
    return decode request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
    raise UnauthorizedException, 'You are not authorized'
  end
end
