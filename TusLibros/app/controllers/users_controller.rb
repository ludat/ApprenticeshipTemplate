class UsersController < ApplicationController
  def login
    session[:user_id] = User.find_by(username: request.params['username'], password: request.params['password']).id
    redirect_to :login
  end

  def index
  end

  def pucharses
    user = User.find(params['id'])
    render json: user.pucharses
  end
end
