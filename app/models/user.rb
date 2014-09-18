class User < ActiveRecord::Base
  def self.master
    User.where(master: true).first
  end

  def credentials
    {username: api_token, password: "api_token"}
  end
end
