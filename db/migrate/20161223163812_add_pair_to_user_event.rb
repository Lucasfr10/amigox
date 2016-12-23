class AddPairToUserEvent < ActiveRecord::Migration
  def change
    add_reference :user_events, :pair, references: :users, index: true
    add_foreign_key :user_events, :users, column: :pair_id

  end
end
