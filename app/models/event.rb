class Event < ActiveRecord::Base
  belongs_to :group
  has_many :user_events
  has_many :users, through: :user_events

  validates :name, presence: true

  def raffle
    pairs = self.users.sort_by { rand }.in_groups_of(2)

    pairs.each do |pair|
      self.user_events.where(:user_id => pair[0].id).take.update(:pair => pair[1])
      self.user_events.where(:user_id => pair[1].id).take.update(:pair => pair[0])

      EventNotification.send_email(pair[0], self).deliver
      EventNotification.send_email(pair[1], self).deliver
    end

    self.update(:raffled => true)
  end
end
