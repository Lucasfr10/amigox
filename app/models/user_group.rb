class UserGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :pair, class_name: "User"
end
