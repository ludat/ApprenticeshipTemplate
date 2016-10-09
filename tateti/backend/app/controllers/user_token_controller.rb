class UserTokenController < ApplicationController
  def create
    user = User.find_by(params.permit :username)
    if user.nil?
      render json: {error: 'Invalid credentials'}, status: :unauthorized
    else
      render json: {
          token: JWT.encode(
              {user: user.as_json(only: [:id, :username])}, nil, 'none')}, status: :created
    end
  end
end
