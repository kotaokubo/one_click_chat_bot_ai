# OneClickChatBotAI Web Server

## 起動方法

```bash
# プロジェクトディレクトリに移動
cd one_click_chat_bot_ai

# Docker Composeでサーバー起動
docker-compose up -d

# ログ確認
docker-compose logs -f

# サーバー停止
docker-compose down
```

## アクセス

- **サービス仕様書**: http://localhost:8080
- **直接アクセス**: http://localhost:8080/service-spec.html

## 構成

```
one_click_chat_bot_ai/
├── docker-compose.yml   # Docker Compose設定
├── nginx.conf          # Nginx設定
├── service-spec.html   # サービス仕様書（メインページ）
├── todo.md            # TODO リスト
└── README.md          # このファイル
```

## 設定

- **ポート**: 8080
- **Webサーバー**: Nginx (Alpine Linux)
- **ドキュメントルート**: `./one_click_chat_bot_ai/`
- **デフォルトページ**: `service-spec.html`

## 開発時の使い方

1. HTMLファイルを編集
2. ブラウザでリロードして確認
3. リアルタイムで変更が反映されます

## トラブルシューティング

### ポート8080が使用中の場合
```bash
# ポートを変更 (例: 8081)
# docker-compose.yml の ports を "8081:80" に変更
```

### コンテナが起動しない場合
```bash
# コンテナとイメージを削除して再構築
docker-compose down
docker-compose up -d --force-recreate
```
