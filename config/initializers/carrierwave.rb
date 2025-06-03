CarrierWave.configure do |config|
  # アップロードされた画像のベースURLを設定
  # フロントエンドから画像にアクセスする際のホスト名
  config.asset_host = "http://localhost:3001"
  
  # ファイルの保存方法を指定（ローカルファイルシステム）
  # 本番環境では :fog (AWS S3など) を使用することが多い
  config.storage = :file
  
  # 一時的なキャッシュファイルの保存方法
  # アップロード処理中の一時保存場所
  config.cache_storage = :file
end
