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
    end

    self.update(:raffled => true)
  end
end
