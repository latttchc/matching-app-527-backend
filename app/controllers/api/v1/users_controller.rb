class Api::V1::UsersController < ApplicationController
    # show, updateアクション実行前にユーザー情報を取得
    before_action :set_user, only: %i[show update]

    # マッチング候補ユーザー一覧取得
    def index
        # マッチング条件:
        # 1. 同じ都道府県に住んでいる
        # 2. 異性である（gender値が異なる）
        # 3. 自分以外のユーザー
        users = User.where(prefecture: current_api_v1_user.prefecture)  # 同じ都道府県
                    .where.not(
                        id: current_api_v1_user.id,                    # 自分を除外
                        gender: current_api_v1_user.gender             # 異性のみ（同性を除外）
                    )       
                    .order("created_at DESC")                          # 新規登録順（新しい人が上）
        
        render json: {
            status: 200, 
            users: users
        }
    end

    # 特定ユーザーの詳細情報取得
    def show
        # @userはbefore_actionのset_userで既に設定済み
        render json: {
            status: 200, 
            user: @user  # プロフィール詳細表示用
        }
    end

    # ユーザー情報更新（プロフィール編集）
    def update
        # 各フィールドを個別に更新
        @user.name = user_params[:name]               # 名前更新
        @user.prefecture = user_params[:prefecture]   # 都道府県更新
        @user.profile = user_params[:profile]         # 自己紹介文更新
        
        # 画像は空文字列でない場合のみ更新（画像削除を防ぐ）
        @user.image = user_params[:image] if user_params[:image] != ""

        # データベースに保存
        if @user.save
            render json: {
                status: 200, 
                user: @user  # 更新後のユーザー情報を返す
            }
        else
            render json: {
                status: 500, 
                message: "更新に失敗しました。"
            }
        end
    end

    private
        # URLパラメータからユーザーを取得してインスタンス変数に格納
        def set_user
            @user = User.find(params[:id])
        end

        # Strong Parameters: 更新を許可するパラメータを制限
        def user_params
            params.permit(:name, :prefecture, :profile, :image)
        end
end
