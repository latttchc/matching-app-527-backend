class CreateChatRoomUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_room_users do |t|
      t.integer :chat_rooms_id, null: false # チャットルームのID
      t.integer :user_id, null: false # ユーザーのID

      t.timestamps
    end
  end
end
