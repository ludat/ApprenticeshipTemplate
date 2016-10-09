class UserTokenController < ApplicationController
  def create
    render json: {
        token: JWT.encode({
                              user: {id: 1}
                          },
                          nil,
                          'none'
        )}
  end
end
