class User < ActiveRecord::Base
  validates :name, :password, presence: true
  validates :email, uniqueness: true

  def self.login(email, password)
    user = User.where(:email => email, :password => password).take
    return user != nil ? user : nil
  end
end
