class AddSenderToChat < ActiveRecord::Migration
  def change
    add_reference :chats, :sender, references: :users, index: true
    add_foreign_key :chats, :users, column: :sender_id
  end
end
