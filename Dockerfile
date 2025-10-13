# ベースイメージとして軽量なNginx Alpineを使用
FROM nginx:alpine

# メンテナ情報
LABEL maintainer="OneClickChatBotAI"
LABEL description="OneClickChatBotAI Web Server"

# 作業ディレクトリを設定
WORKDIR /usr/share/nginx/html

# デフォルトのNginx設定を削除
RUN rm -rf /usr/share/nginx/html/*
RUN rm /etc/nginx/nginx.conf

# カスタムNginx設定をコピー
COPY nginx.conf /etc/nginx/nginx.conf

# HTMLファイルをコピー
COPY service-spec.html /usr/share/nginx/html/
COPY README.md /usr/share/nginx/html/

# ポート80を公開
EXPOSE 80

# ヘルスチェックを追加
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Nginxをフォアグラウンドで実行
CMD ["nginx", "-g", "daemon off;"]

