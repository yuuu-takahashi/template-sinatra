# template-sinatra

このリポジトリはSinatraのテンプレートプロジェクトです。
このプロジェクトは、[Dev Container](https://code.visualstudio.com/docs/devcontainers/containers)での利用を想定した構成になっています。

## 目次

- [template-sinatra](#template-sinatra)
  - [目次](#目次)
  - [使用技術](#使用技術)
  - [ディレクトリ構成](#ディレクトリ構成)
  - [開発環境構築](#開発環境構築)
  - [必要なツール](#必要なツール)
    - [開発環境の準備](#開発環境の準備)
  - [開発作業ガイド](#開発作業ガイド)
  - [トラブルシューティング](#トラブルシューティング)

## 使用技術

| 言語・フレームワーク | バージョン |
| -------------------- | ---------- |
| Ruby                 | 3.3.x      |
| Node.js              | 22.x.x     |

## ディレクトリ構成

```bash
tree -I 'vendor|node_modules'
.
├── Gemfile                      # プロジェクトの依存関係
├── Gemfile.lock                 # 固定された依存関係のバージョンの記録
├── Rakefile                     # Rakeタスク
├── app                          # アプリケーションの主要ロジック
│   ├── controllers              # コントローラー：HTTPリクエストの処理とレスポンスの生成
│   └── models                   # モデル：データベースとのやりとりとビジネスロジック
├── config                       # アプリケーションの設定ファイル
│   ├── environment.rb           # 環境ごとの設定の管理
│   ├── routes.rb                # ルーティング
│   └── setup.rb                 # アプリケーション全体のセットアップ処理
├── db                           # データベース関連のファイル
│   ├── migrate                  # マイグレーションファイル
│   ├── schema.rb                # データベーススキーマ
│   ├── seeds                    # シードデータ（初期データ）
│   └── setup.rb                 # データベースのセットアップ処理
├── spec                         # テストコード
│   ├── controllers              # コントローラーのテストコード
│   ├── factories                # FactoryBot設定
│   ├── models                   # モデルのテストコード
│   ├── spec_helper.rb           # RSpecの基本設定
│   └── support                  # テストサポート用のファイル
```

## 開発環境構築

## 必要なツール

- [VS Code](https://code.visualstudio.com/)
- [Docker](https://www.docker.com/ja-jp/)
- VS Codeの[Dev Containers拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### 開発環境の準備

1. リポジトリをクローン

   ```bash
   git clone git@github.com:yuuu-takahashi/template-sinatra.git
   cd template-sinatra
   ```

2. 環境変数の設定

   ```bash
   cp example.env .env.development
   ```

3. VS Codeのの左下「><」アイコンをクリックし、「Remote-Containers: Reopen in Container」を選択し、起動


4. データベース準備

   ```bash
   bundle exec rake db:setup
   bundle exec rake db:seed
   ```

5. 開発サーバー起動

   ```bash
   bundle exec ruby index.rb
   ```

ブラウザでhttp://localhost:4567を開き、表示確認

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
