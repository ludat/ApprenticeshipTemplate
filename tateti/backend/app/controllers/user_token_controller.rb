class UserTokenController < ApplicationController

  around_action :exception_catcher

  def create
    user = User.login(params.require(:username), params.require(:password))
    render json: {
        token: JWT.encode(
            {user: user.as_json(only: [:id, :username])}, nil, 'none')}, status: :created
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
