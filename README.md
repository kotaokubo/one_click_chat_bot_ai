# OneClickChatBotAI Web Server

## 起動方法

### Docker Composeを使用（推奨）

```bash
# プロジェクトディレクトリに移動
cd one_click_chat_bot_ai

# イメージをビルドしてサーバー起動
docker-compose up -d --build

# ログ確認
docker-compose logs -f

# サーバー停止
docker-compose down
```

### Dockerfileのみを使用

```bash
# Dockerイメージをビルド
docker build -t oneclick-chatbot-web:latest .

# コンテナを起動
docker run -d -p 8080:80 --name oneclick-chatbot-web oneclick-chatbot-web:latest

# ログ確認
docker logs -f oneclick-chatbot-web

# コンテナを停止・削除
docker stop oneclick-chatbot-web
docker rm oneclick-chatbot-web
```

## fly.ioへのデプロイ

### 初回デプロイ

```bash
# fly.io CLIをインストール（未インストールの場合）
# macOS
brew install flyctl

# または
curl -L https://fly.io/install.sh | sh

# fly.ioにログイン
flyctl auth login

# アプリ名を変更（任意）
# fly.toml の app = "oneclick-chatbot-ai" を変更

# アプリを作成してデプロイ
flyctl launch --no-deploy

# デプロイ実行
flyctl deploy
```

### 更新デプロイ

```bash
# コードを変更後、再デプロイ
flyctl deploy

# デプロイ状況確認
flyctl status

# ログ確認
flyctl logs

# アプリを開く
flyctl open
```

### fly.io 管理コマンド

```bash
# アプリ情報確認
flyctl info

# スケーリング
flyctl scale count 1

# マシンの停止
flyctl scale count 0

# アプリの削除
flyctl apps destroy oneclick-chatbot-ai
```

## アクセス

### ローカル環境
- **サービス仕様書**: http://localhost:8080
- **直接アクセス**: http://localhost:8080/service-spec.html

### fly.io本番環境
- **URL**: https://oneclick-chatbot-ai.fly.dev
  ※ アプリ名を変更した場合は `https://<your-app-name>.fly.dev`

## 構成

```
one_click_chat_bot_ai/
├── Dockerfile          # Docker設定
├── docker-compose.yml  # Docker Compose設定
├── fly.toml            # fly.io設定
├── .dockerignore       # Dockerビルドから除外するファイル
├── nginx.conf          # Nginx設定
├── service-spec.html   # サービス仕様書（メインページ）
└── README.md           # このファイル
```

## 設定

### ローカル環境
- **ポート**: 8080
- **Webサーバー**: Nginx (Alpine Linux)
- **ドキュメントルート**: `/usr/share/nginx/html`
- **デフォルトページ**: `service-spec.html`

### fly.io環境
- **リージョン**: Tokyo (Narita) - `nrt`
- **メモリ**: 256MB
- **CPU**: 1 shared
- **自動停止**: 有効（アクセスがない場合）
- **HTTPS**: 強制リダイレクト

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
docker-compose build --no-cache
docker-compose up -d
```

### イメージを完全にクリーンビルドする場合
```bash
# すべてのコンテナとイメージを削除
docker-compose down --rmi all
docker-compose up -d --build
```
