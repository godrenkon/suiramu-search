#!/bin/bash
# suiramu-data という名前のプライベートリポジトリを使って
# ブックマーク(bookmarks.json)を保存・復元する
# パスワードやトークンは扱わず、Codespace に元々ある gh CLI の認証をそのまま使う

DATA_REPO="suiramu-data"
LOCAL_DATA_DIR="$HOME/.suiramu-data"

echo "🔗 GitHubアカウントと連携中..."

# gh CLI がログイン済みか確認（Codespace内では通常自動でログイン済み）
if ! gh auth status > /dev/null 2>&1; then
  echo "⚠️  GitHub認証が見つかりません。ブックマークの保存はスキップされます。"
  echo "   (このCodespaceのGitHub連携設定をご確認ください)"
  mkdir -p "$LOCAL_DATA_DIR"
  echo "[]" > "$LOCAL_DATA_DIR/bookmarks.json"
  exit 0
fi

USERNAME=$(gh api user --jq .login 2>/dev/null)
echo "👤 ログイン中: $USERNAME"

# プライベートリポジトリが存在するか確認、なければ作成
if ! gh repo view "$USERNAME/$DATA_REPO" > /dev/null 2>&1; then
  echo "📦 データ保存用リポジトリを作成中（あなた専用・非公開）..."
  gh repo create "$DATA_REPO" --private --description "Suiramu bookmarks & settings (private)" > /dev/null 2>&1
  echo "✅ 作成完了: $USERNAME/$DATA_REPO (Private)"
fi

# ローカルにクローン/更新
mkdir -p "$LOCAL_DATA_DIR"
if [ -d "$LOCAL_DATA_DIR/.git" ]; then
  echo "🔄 保存済みデータを取得中..."
  (cd "$LOCAL_DATA_DIR" && git pull --quiet 2>/dev/null) || true
else
  rm -rf "$LOCAL_DATA_DIR"
  gh repo clone "$USERNAME/$DATA_REPO" "$LOCAL_DATA_DIR" -- --quiet 2>/dev/null
fi

# bookmarks.json が無ければ初期化
if [ ! -f "$LOCAL_DATA_DIR/bookmarks.json" ]; then
  echo "[]" > "$LOCAL_DATA_DIR/bookmarks.json"
  (cd "$LOCAL_DATA_DIR" && git config user.email "$USERNAME@users.noreply.github.com" && git config user.name "$USERNAME" && git add bookmarks.json && git commit -m "Initial bookmarks" --quiet && git push --quiet 2>/dev/null) || true
fi

echo "✅ データ連携完了 ($USERNAME/$DATA_REPO)"
