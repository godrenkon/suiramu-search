#!/bin/bash

echo "🔍 Suiramu【検索特化モード】起動準備中..."

pkill Xvfb 2>/dev/null || true
pkill x11vnc 2>/dev/null || true
pkill fluxbox 2>/dev/null || true
pkill -f websockify 2>/dev/null || true
pkill -f chrome 2>/dev/null || true
pkill -f "node .devcontainer/server.js" 2>/dev/null || true
sleep 1

bash .devcontainer/sync_data.sh

echo "📡 データサーバー起動中..."
node .devcontainer/server.js > /tmp/suiramu-server.log 2>&1 &
sleep 1

echo "🖥️  仮想ディスプレイ起動中..."
Xvfb :1 -screen 0 1280x800x24 &
sleep 2
export DISPLAY=:1

echo "🪟 ウィンドウマネージャ起動中..."
fluxbox > /tmp/fluxbox.log 2>&1 &
sleep 1

echo "📡 VNCサーバー起動中..."
x11vnc -display :1 -forever -shared -nopw -quiet &
sleep 1

# ==== 検索特化: 文字がくっきり見える高品質設定 ====
echo "🌐 noVNC 起動中（検索特化・高精細設定）..."

# noVNC標準の接続画面(サーバー名などの入力を求める画面)を経由せず、
# 開いた瞬間に自動でSuiramuに繋がる専用ページをWebルートに配置する
cp -f home/connect.html /opt/novnc/index.html 2>/dev/null || true

/opt/novnc/utils/novnc_proxy \
  --vnc localhost:5900 \
  --listen 6080 &
sleep 2

CHROME_PROFILE="$HOME/.suiramu-chrome-profile-search"
mkdir -p "$CHROME_PROFILE"

# setup.sh が確認したChromiumの実行ファイルパスを使う
if [ -f /tmp/suiramu-chrome-bin ]; then
  CHROME_BIN=$(cat /tmp/suiramu-chrome-bin)
fi

if [ -z "$CHROME_BIN" ] || [ ! -x "$CHROME_BIN" ]; then
  echo ""
  echo "❌ Chromiumが見つかりません。"
  echo "   npm run setup を実行してセットアップをやり直してください。"
  echo ""
  exit 1
fi

echo "🌏 ブラウザ起動中..."
"$CHROME_BIN" \
  --no-sandbox \
  --disable-gpu \
  --disable-dev-shm-usage \
  --start-maximized \
  --window-position=0,0 \
  --window-size=1280,800 \
  --no-first-run \
  --disable-infobars \
  --force-color-profile=srgb \
  --user-data-dir="$CHROME_PROFILE" \
  --restore-last-session \
  "file://$(pwd)/home/search.html" \
  > /tmp/suiramu-chrome.log 2>&1 &

CHROME_PID=$!
sleep 3

if ! kill -0 "$CHROME_PID" 2>/dev/null; then
  echo ""
  echo "❌ ブラウザの起動に失敗しました。"
  echo "   ログを確認してください: cat /tmp/suiramu-chrome.log"
  echo ""
else
  echo ""
  echo "✅ 起動完了！【検索特化モード】"
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  Codespace の「ポート」タブを開いて"
  echo "  6080番ポートのURLをクリックしてください"
  echo "  （自動でSuiramuの画面に接続されます）"
  echo ""
  echo "  💡 文字がくっきり見える設定になっています"
  echo "  💡 動画を見るなら Ctrl+C で止めて"
  echo "     npm run video を実行してください"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
fi

wait
