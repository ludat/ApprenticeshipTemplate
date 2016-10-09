class User < ActiveRecord::Base
  has_and_belongs_to_many :games

  def self.login(username, password)
    user = User.find_by(username: username, password: password)
    raise UnauthorizedException, 'Invalid credentials' if user.nil?
    user
  end
end
