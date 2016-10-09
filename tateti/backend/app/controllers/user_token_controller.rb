class UserTokenController < ApplicationController

  around_action :exception_catcher

  def create
    user = User.login(params.require(:username), params.require(:password))
    render json: {
        token: JWT.encode(
            {user: UserSerializer.new(user).as_json}, nil, 'none')}, status: :created
  end

  private
  def exception_catcher
    begin
      yield
    rescue UnauthorizedException => e
      render json: {error: e.message}, status: :unauthorized
    end
  end
end
