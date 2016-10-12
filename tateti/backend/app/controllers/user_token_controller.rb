class UserTokenController < ApplicationController

  include ExceptionHandler

  def create
    user = User.login(params.require(:username), params.require(:password))
    render json: {token: JwtService.encode({user: UserSerializer.new(user).as_json})}, status: :created
  end

end
