# 💘 Matching App Backend (Rails API)

Rails 8 + MySQL を使用したマッチングアプリのバックエンドAPIです。  
JWTベースの認証と、マッチング・チャット機能を提供します。

---

## 🚀 機能概要

### ✨ 主要機能
- **ユーザー認証**（`devise_token_auth` 使用）
- **プロフィール管理**（画像アップロード付き）
- **マッチング機能**（都道府県・性別ベース）
- **いいね機能**（双方向でマッチング成立）
- **チャット機能**（マッチング後のメッセージ送信）

### 🎯 マッチング条件
- 同じ都道府県
- 性別が異なる
- 双方が「いいね」を送っている

---

## 🛠 技術スタック

| 項目              | 使用技術               |
|-------------------|------------------------|
| 言語              | Ruby 3.2+              |
| フレームワーク    | Rails 8.0 (API mode)   |
| DB                | MySQL 8.0              |
| 認証              | devise_token_auth      |
| 画像アップロード  | CarrierWave            |
| 開発環境          | Docker / Docker Compose|

---

## 📋 API エンドポイント

### 🔐 認証
POST /api/v1/auth # ユーザー登録  
POST /api/v1/auth/sign_in # ログイン  
DELETE /api/v1/auth/sign_out # ログアウト  
GET /api/v1/auth/sessions # ログイン状態確認  

### 👤 ユーザー管理
GET /api/v1/users # マッチング候補一覧  
GET /api/v1/users/:id # ユーザー詳細  
PATCH /api/v1/users/:id # プロフィール更新  

### ❤️ いいね
GET /api/v1/likes # 自分から/相手からのいいね一覧  
POST /api/v1/likes # いいね送信（マッチングも判定）  

### 💬 チャット
GET /api/v1/chat_rooms # チャットルーム一覧  
GET /api/v1/chat_rooms/:id # メッセージ履歴  
POST /api/v1/messages # メッセージ送信  

### 🩺 ヘルスチェック
GET /up # アプリケーション正常性確認  

---

## 🗄️ データベース設計

### users
| カラム       | 型       | 説明              |
|--------------|----------|-------------------|
| name         | string   | 表示名            |
| email        | string   | メールアドレス    |
| gender       | integer  | 性別（0:男性, 1:女性）|
| birthday     | date     | 生年月日          |
| prefecture   | integer  | 都道府県コード     |
| profile      | text     | 自己紹介文         |
| image        | string   | プロフィール画像パス|

### likes
| カラム         | 型       | 説明           |
|----------------|----------|----------------|
| from_user_id   | integer  | 送信者ID       |
| to_user_id     | integer  | 受信者ID       |

### chat_rooms / chat_room_users / messages
- `chat_rooms`: ルーム管理  
- `chat_room_users`: 中間テーブル（room_id, user_id） 
- `messages`: チャット本文（room_id, user_id, content）

---

## 🚀 セットアップ手順

### 1. リポジトリをクローン
```bash
git clone https://github.com/your-user/matching-app-backend.git
cd matching-app-backend
```

2. DockerビルドとDBセットアップ
```bash
docker compose build
docker compose run api rails db:create
docker compose run api rails db:migrate
docker compose up
```


## 🔧 開発構成
```
├── app/
│   ├── controllers/api/v1/
│   │   ├── auth/
│   │   ├── chat_rooms_controller.rb
│   │   ├── likes_controller.rb
│   │   ├── messages_controller.rb
│   │   └── users_controller.rb
│   ├── models/
│   │   ├── user.rb
│   │   ├── like.rb
│   │   ├── chat_room.rb
│   │   └── message.rb
│   └── uploaders/
│       └── image_uploader.rb
├── config/
│   ├── routes.rb
│   └── initializers/carrierwave.rb
└── db/migrate/
```

## 📄 ライセンス
This project is licensed under the MIT License.

マッチングアプリの恋が始まる場所 💕
