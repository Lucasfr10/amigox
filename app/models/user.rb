class User < ActiveRecord::Base
  has_many :user_groups
  has_many :groups, through: :user_groups

  has_many :user_events
  has_many :events, through: :user_events
  has_one :pair, through: :user_events

  validates :name, :password, presence: true
  validates :email, uniqueness: true

  def self.login(email, password)
    user = User.where(:email => email, :password => password).take
    return user != nil ? user : nil
  end

  def pair(event)
    user = event.user_events.where(:user_id => self.id).take
    user.pair
  end
end
