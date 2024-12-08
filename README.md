# template-sinatra

このリポジトリはSinatraのテンプレートプロジェクトです。

## 開発環境のセットアップ

### 準備

- [VS Code](https://code.visualstudio.com/)をインストール
- [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)をインストール
- [Docker](https://www.docker.com/ja-jp/)をインストール

### セットアップ手順

```bash
git clone git@github.com:yuuu-takahashi/template-sinatra.git
cd template-sinatra
```

### Dev Containerの起動

VS Codeの左下「><」アイコンをクリックし、「Remote-Containers: Reopen in Container」を選択して起動します。

### サーバーの起動

```bash
bundle exec ruby index.rb
```

http://localhost:3000 で確認できます
