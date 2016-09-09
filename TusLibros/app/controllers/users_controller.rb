class UsersController < ApplicationController
  def login
    session[:user] = User.find_by(name: request.params['username'], password: request.params['password'])
    p session[:user]
    redirect_to "/users"
  end
  def index
    p session[:user]
  end
end
