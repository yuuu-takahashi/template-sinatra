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
├── app                          # アプリケーションの主要なロジック
│   ├── controllers              # コントローラーを格納
│   └── models                   # モデルを格納
├── config                       # 設定ファイルや初期設定ファイル
│   ├── initializers             # 初期化処理用の設定
│   └── routes.rb                # ルーティング設定
├── db                           # データベース関連のファイル
│   ├── seeds                    # シードデータ
│   └── setup.rb                 # セットアップスクリプト
├── index.rb                     # アプリケーションのエントリーポイント
├── lib                          # ライブラリやタスク関連のコード
│   └── tasks                    # Rakeタスク
├── package.json                 # Node.jsの依存関係を定義
├── spec                         # テストコード
│   ├── controllers              # コントローラーのテスト
│   ├── factories                # テストデータの定義
│   ├── models                   # モデルのテスト
│   └── support                  # テスト用サポートモジュール
└── yarn.lock                    # 固定された依存関係のバージョンを記録
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

- テスト

```bash
bundle exec rspec
```

- コードチェック

```bash
bundle exec rubocop -A
```

## トラブルシューティング

TODO:
