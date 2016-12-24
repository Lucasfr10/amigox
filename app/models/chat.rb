class Chat < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :reciver, class_name: "User"

  def self.send_message(sender_id, receiver_id, message)
    chat = Chat.new

    chat.sender_id = sender_id
    chat.receiver_id = receiver_id
    chat.message = message

    chat.save
  end

end
