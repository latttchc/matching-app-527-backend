class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.integer :chat_room_id, null: false # チャットルームのID
      t.integer :user_id, null: false # メッセージを送信したユーザーのID
      t.string :content, null: false # メッセージの内容

      t.timestamps
    end
  end
end
