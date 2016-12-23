class UserEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :pair, class_name: "User"
end
