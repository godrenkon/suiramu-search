#!/bin/bash
# suiramu-data という名前のプライベートリポジトリを使って
# ブックマーク(bookmarks.json)を保存・復元する
# パスワードやトークンは扱わず、Codespace に元々ある GitHub 認証をそのまま使う

DATA_REPO="suiramu-data"
LOCAL_DATA_DIR="$HOME/.suiramu-data"

echo "🔗 GitHubアカウントと連携中..."

# Codespace内には環境変数 GITHUB_TOKEN が自動で入っていることが多いが、
# gh CLI 自身がそれを認識していないケースがある。
# その場合は明示的に GH_TOKEN として渡してあげることでログイン状態を復元する。
if ! gh auth status > /dev/null 2>&1; then
  if [ -n "$GITHUB_TOKEN" ]; then
    export GH_TOKEN="$GITHUB_TOKEN"
  fi
fi

if ! gh auth status > /dev/null 2>&1; then
  echo "⚠️  GitHub認証が見つかりません。ブックマークの保存はスキップされます。"
  echo "   このCodespaceを開き直すか、ターミナルで以下を試してください:"
  echo "     gh auth login"
  mkdir -p "$LOCAL_DATA_DIR"
  [ -f "$LOCAL_DATA_DIR/bookmarks.json" ] || echo "[]" > "$LOCAL_DATA_DIR/bookmarks.json"
  exit 0
fi

USERNAME=$(gh api user --jq .login 2>/dev/null)
echo "👤 ログイン中: $USERNAME"

# プライベートリポジトリが存在するか確認、なければ作成
if ! gh repo view "$USERNAME/$DATA_REPO" > /dev/null 2>&1; then
  echo "📦 データ保存用リポジトリを作成中（あなた専用・非公開）..."
  if gh repo create "$DATA_REPO" --private --description "Suiramu bookmarks & settings (private)" > /dev/null 2>&1; then
    echo "✅ 作成完了: $USERNAME/$DATA_REPO (Private)"
  else
    echo "⚠️  リポジトリの自動作成に失敗しました（権限不足の可能性があります）。"
    echo "   ブックマークはこのCodespace内だけに一時保存されます。"
    mkdir -p "$LOCAL_DATA_DIR"
    [ -f "$LOCAL_DATA_DIR/bookmarks.json" ] || echo "[]" > "$LOCAL_DATA_DIR/bookmarks.json"
    exit 0
  fi
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
