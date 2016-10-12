class JwtService
  def self.encode(json)
    JWT.encode(json, nil, 'none')
  end

  def self.decode(token)
    JWT.decode(token, nil, false).first
  end
end