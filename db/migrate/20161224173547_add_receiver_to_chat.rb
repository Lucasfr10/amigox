class AddReceiverToChat < ActiveRecord::Migration
  def change
    add_reference :chats, :receiver, references: :users, index: true
    add_foreign_key :chats, :users, column: :receiver_id
  end
end
