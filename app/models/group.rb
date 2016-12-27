class Group < ActiveRecord::Base
  belongs_to :user
  has_many :events
  has_many :user_groups
  has_many :users, through: :user_groups

  validates :name, presence: true

  def send_invite
    self.users.joins(:user_groups).where(:user_groups => {:invite_flag => false}).each do |user|
      GroupInvite.send_email(user, self).deliver
    end
  end

  def accept_invite(user_id)
    self.user_groups.where(:user_id => user_id).take.update(:invite_flag => true)
  end

  def accept_invite(user_id)
    self.user_groups.where(:user_id => user_id).take.update(:invite_flag => false)
  end

  def all_accepts
    return self.user_groups.count == self.user_groups.where(:invite_flag => true).count ? true : false
  end
end
