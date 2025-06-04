class Api::V1::LikesController < ApplicationController
    def index
        render json: {
            status: 200,
            active_likes: current_api_v1_user.active_likes, #自分からのいいね
            passive_likes: current_api_v1_user.passive_likes #相手へのいいね
        }
    end

    def create
        is_matched = false # マッチングしているかどうか

        active_like = Like.find_or_initialize_by(like_params)
        passive_like = Like.find_by(
            from_user_id: active_like.to_user_id,
            to_user_id: active_like.from_user_id
        )

        if passive_like # いいねを押した際に相手がいいねを押していたら成立
            chat_room = ChatRoom.create
            
            # 自分
            ChatRoomUser.find_or_create_by(
                chat_room_id: chat_room.id,
                user_id: active_like.from_user_id
            )
            # 相手
            ChatRoomUser.find_or_create_by(
                chat_room_id: chat_room.id,
                user_id: passive_like.from_user_id
            )

            is_matched = true
        end

        if active_like.save
            render json: {
                status: 200,
                like: active_like,
                is_matched: is_matched
            }
        else
            render json: {
                status: 500,
                message: "作成失敗しました"
            }
        end
    end

    private
        def like_params
            params.permit(:from_user_id, :to_user_id)
        end
end
