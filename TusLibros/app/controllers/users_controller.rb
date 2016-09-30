class UsersController < ApplicationController

  include CartControllerExceptionHandler

  def login
    session[:user_id] = User.find_by(username: request.params['username'], password: request.params['password']).id
    redirect_to :login
  end

  def index
  end

  def purchases
    user = User.login(id: params.require(:id), password: params.require(:password))
    render json: user.purchases
  end
end
