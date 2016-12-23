class Group < ActiveRecord::Base
  belongs_to :user
  has_many :user_groups
  has_many :users, through: :user_groups

  validates :name, presence: true

  def raffle
    pairs = self.users.sort_by { rand }.in_groups_of(2)

    pairs.each do |pair|
      self.user_groups.where(:user_id => pair[0].id).take.update(:pair => pair[1])
      self.user_groups.where(:user_id => pair[1].id).take.update(:pair => pair[0])
      GroupInvite.sample_email(pair[0], self).deliver
    end

    self.update(:raffled => true)
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
