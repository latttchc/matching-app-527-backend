class CreateChatRoomUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_room_users do |t|
      t.timestamps
    end
  end
end
