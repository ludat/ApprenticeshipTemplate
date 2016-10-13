module AuthorizationHelper
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