class Api::V1::ChatRoomsController < ApplicationController
    before_action :set_chat_room, only: %i[show]

    # チャットルーム一覧を取得（マッチング済みの相手一覧）
    def index
        chat_rooms = []

        # 現在のユーザーが参加しているチャットルームを新しい順に取得
        current_api_v1_user.chat_room_users.order("created_at DESC").each do |chat_room|
            # 部屋情報(相手のユーザは誰か、最後に送信されたメッセージは何か)をJSON形式で作成
            chat_rooms << {
                chat_room: chat_room,
                other_user: chat_room.user.where.not(id: current_api_v1_user.id)[0],
                last_message: chat_room.messages[-1]
            }
        end

        render json: {
            status: 200,
            chat_rooms: chat_rooms
        }
    end

    # 特定のチャットルームの詳細を取得（メッセージ履歴）
    def show
        # チャットルームの相手ユーザーを取得（自分以外）
        other_user = @chat_room.users.where.not(id: current_api_v1_user.id)[0]
        # メッセージを古い順に取得（チャット画面での表示順）
        messages = @chat_room.messages.order("created_at ASC")

        render json: {
            status: 200,
            other_user: other_user,
            messages: messages
        }
    end

    private
        # チャットルームを取得するためのメソッド
        def set_chat_room
            @chat_room = ChatRoom.find(params[:id])
        end
end
