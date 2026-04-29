# OpenProject

OpenProject Community Edition を Docker Compose で起動するための構成です。
公式の Docker Compose 方式に合わせて、OpenProject、PostgreSQL、memcached、Caddy、Hocuspocus を分離して起動します。

## 前提

- Docker Engine
- Docker Compose plugin

Ubuntu への Docker Engine 導入は Docker 公式手順を参照してください。
https://docs.docker.com/engine/install/ubuntu/

## 初回起動

```bash
cd openproject
bash scripts/generate-env.sh
docker compose pull
docker compose up -d
```

起動後、以下で開きます。

```text
http://localhost:8080
```

初期ログインは OpenProject の既定値です。

```text
user: admin
password: admin
```

初回ログイン後、管理者パスワードを変更してください。

## ローカル設定

`.env` はコミットしません。設定例は `.env.example` にあります。

主な値:

- `PORT`: 公開する待受ポート。初期値は `127.0.0.1:8080` です。
- `OPENPROJECT_HOST__NAME`: ブラウザからアクセスするホスト名です。
- `OPENPROJECT_HTTPS`: TLS 終端済みのリバースプロキシ配下では `true` にします。
- `SECRET_KEY_BASE`: Rails のシークレットです。必ずランダム値にします。
- `COLLABORATIVE_SERVER_SECRET`: 共同編集サーバー用のシークレットです。
- `POSTGRES_PASSWORD`: PostgreSQL のパスワードです。

## 運用コマンド

```bash
cd openproject
docker compose ps
docker compose logs -f web
docker compose down
docker compose up -d --pull always
```

## データ永続化

既定では Docker named volume を使います。

- `pgdata`: PostgreSQL データ
- `opdata`: OpenProject 添付ファイル

ホストディレクトリに保存したい場合は `.env` の `PGDATA` と `OPDATA` を絶対パスに変更してください。

## 公式ドキュメント

- OpenProject Docker Compose: https://www.openproject.org/docs/installation-and-operations/installation/docker-compose/
- OpenProject Docker images: https://www.openproject.org/docs/installation-and-operations/installation/docker/
