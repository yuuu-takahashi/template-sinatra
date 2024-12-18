# template-sinatra

このリポジトリはSinatraのテンプレートプロジェクトです。

## 目次

- [template-sinatra](#template-sinatra)
  - [目次](#目次)
  - [使用技術](#使用技術)
  - [開発環境構築](#開発環境構築)
    - [準備](#準備)
    - [開発サーバーセットアップ](#開発サーバーセットアップ)
  - [ディレクトリ構成](#ディレクトリ構成)
  - [トラブルシューティング](#トラブルシューティング)

## 使用技術

| 言語・フレームワーク | バージョン |
| -------------------- | ---------- |
| Ruby                 | 3.1.x      |
| Node.js              | 20.x.x    |

## 開発環境構築

### 準備

- [VS Code](https://code.visualstudio.com/)をインストール
- [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)をインストール
- [Docker](https://www.docker.com/ja-jp/)をインストール

### 開発サーバーセットアップ

1. リポジトリをclone

   ```bash
   git clone git@github.com:yuuu-takahashi/template-sinatra.git
   cd template-sinatra
   ```

2. Dev Containerの起動

   VS Codeの左下「><」アイコンをクリックし、「Remote-Containers: Reopen in Container」を選択して起動します。

3. データベース準備

   ```bash
   bundle exec rake db:setup
   ```

4. 開発サーバーの起動

   ```bash
   bundle exec ruby index.rb
   ```
  
  <http://localhost:4567> で確認できます

## ディレクトリ構成

```bash
.
├── Gemfile
├── Gemfile.lock
├── README.md
├── Rakefile
├── app
│   ├── controllers
│   │   └── users_controller.rb
│   ├── models
│   │   └── user.rb
│   └── services
│       └── database_client.rb
├── db
│   ├── schema.rb
│   ├── seeds.rb
│   └── setup.rb
├── index.rb
├── package.json
├── spec
│   ├── factories
│   │   └── user.rb
│   ├── models
│   │   └── user_spec.rb
│   └── spec_helper.rb
└── yarn.lock
```

## トラブルシューティング

TODO:
