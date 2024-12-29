# template-sinatra

このリポジトリはSinatraのテンプレートプロジェクトです。

## 目次

- [template-sinatra](#template-sinatra)
  - [目次](#目次)
  - [使用技術](#使用技術)
  - [ディレクトリ構成](#ディレクトリ構成)
  - [開発環境構築](#開発環境構築)
    - [準備](#準備)
    - [開発サーバーセットアップ](#開発サーバーセットアップ)
  - [開発作業ガイド](#開発作業ガイド)
  - [トラブルシューティング](#トラブルシューティング)

## 使用技術

| 言語・フレームワーク | バージョン |
| -------------------- | ---------- |
| Ruby                 | 3.1.x      |
| Node.js              | 20.x.x     |

## ディレクトリ構成

```bash
tree -I 'vendor|node_modules'
.
├── Gemfile                      # プロジェクトの依存関係を定義
├── Gemfile.lock                 # 固定された依存関係のバージョンを記録
├── README.md                    # プロジェクトの概要や使い方を記載
├── Rakefile                     # Rakeタスクを定義
├── app                          # アプリケーションの主要なロジックを格納
│   ├── controllers              # コントローラー。HTTPリクエストを処理しレスポンスを生成
│   └── models                   # モデル。データベースとのやりとりやビジネスロジックを担当
├── config                       # アプリケーションの設定ファイルを格納
│   ├── environment.rb           # 環境ごとの設定を管理
│   ├── initializers             # 初期化処理をまとめたファイル群
│   ├── routes.rb                # ルーティング設定
│   └── setup.rb                 # アプリケーション全体のセットアップ処理
├── db                           # データベース関連のファイルを格納
│   ├── migrate                  # マイグレーションファイルを格納
│   ├── schema.rb                # データベーススキーマを定義
│   ├── seeds                    # シードデータ（初期データ）を格納
│   └── setup.rb                 # データベースのセットアップ処理
├── spec                         # テストコードを格納
│   ├── controllers              # コントローラーのテストコード
│   ├── factories                # テストデータ生成の設定（FactoryBot）
│   ├── models                   # モデルのテストコード
│   ├── spec_helper.rb           # RSpecの基本設定
│   └── support                  # テストサポート用のファイル
```

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

3. 環境変数の設定

   ```bash
   cp example.env .env
   ```

4. データベース準備

   ```bash
   bundle exec rake db:setup
   bundle exec rake db:seed
   ```

5. 開発サーバーの起動

   ```bash
   bundle exec ruby index.rb
   ```

<http://localhost:4567> で確認できます。

## 開発作業ガイド

- マイグレーションファイルの追加

```bash
bundle exec rake db:generate_migrate[ファイル名]
```

例: usersテーブル作成用のマイグレーションファイルを生成する場合

```bash
bundle exec rake db:generate_migrate[create_users]
```

- マイグレーションの実行

```bash
bundle exec rake db:migrate
```

- テストの実行

```bash
bundle exec rspec
```

- コードの静的解析と修正

```bash
bundle exec rubocop -A
```

## トラブルシューティング

TODO:
