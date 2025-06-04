class ChatRoom < ApplicationRecord
    has_many :chat_room_users
    has_many :users, through: :chat_room_users #中間テーブル(chat_room_users)を通じてusersを取得

    has_many :messages
end
