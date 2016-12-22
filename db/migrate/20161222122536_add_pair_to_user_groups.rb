class AddPairToUserGroups < ActiveRecord::Migration
  def change
    add_reference :user_groups, :pair, references: :users, index: true
    add_foreign_key :user_groups, :users, column: :pair_id
  end
end
