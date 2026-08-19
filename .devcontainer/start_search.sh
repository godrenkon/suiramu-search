#!/bin/bash

echo "🔍 Suiramu【検索特化モード】起動準備中..."

pkill Xvfb 2>/dev/null || true
pkill x11vnc 2>/dev/null || true
pkill fluxbox 2>/dev/null || true
pkill -f websockify 2>/dev/null || true
pkill -f chromium 2>/dev/null || true
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
fluxbox &
sleep 1

echo "📡 VNCサーバー起動中..."
x11vnc -display :1 -forever -shared -nopw -quiet &
sleep 1

# ==== 検索特化: 文字がくっきり見える高品質設定 ====
# フレームレートは低めでよい代わりに、圧縮率を下げて文字を鮮明に保つ
echo "🌐 noVNC 起動中（検索特化・高精細設定）..."
/opt/novnc/utils/novnc_proxy \
  --vnc localhost:5900 \
  --listen 6080 &
sleep 2

CHROME_PROFILE="$HOME/.suiramu-chrome-profile-search"
mkdir -p "$CHROME_PROFILE"

echo "🌏 ブラウザ起動中..."
chromium-browser \
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
  "file://$(pwd)/home/search.html" &

echo ""
echo "✅ 起動完了！【検索特化モード】"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Codespace の「ポート」タブを開いて"
echo "  6080番ポートのURLをクリックしてください"
echo ""
echo "  💡 文字がくっきり見える設定になっています"
echo "  💡 動画を見るなら Ctrl+C で止めて"
echo "     npm run video を実行してください"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

wait
