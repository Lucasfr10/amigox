class User < ActiveRecord::Base
  has_many :user_groups
  has_many :groups, through: :user_groups

  validates :name, :password, presence: true
  validates :email, uniqueness: true

  def self.login(email, password)
    user = User.where(:email => email, :password => password).take
    return user != nil ? user : nil
  end
end
