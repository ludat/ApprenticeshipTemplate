module AuthenticationHelper
  def authenticate!(user)
    @request.headers['Authorization'] = JwtService.encode({user: UserSerializer.new(user).as_json})
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper
end
