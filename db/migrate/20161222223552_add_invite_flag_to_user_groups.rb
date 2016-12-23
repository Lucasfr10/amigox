class AddInviteFlagToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :invite_flag, :boolean, :default => false
  end
end
