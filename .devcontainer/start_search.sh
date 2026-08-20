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

# ==== Chromium実行パスの確認 ====
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

CHROME_PROFILE="$HOME/.suiramu-chrome-profile-search"
mkdir -p "$CHROME_PROFILE"
REPO_DIR="$(pwd)"

# ==== 「もう一度Suiramuを開く」ためのランチャースクリプトを用意 ====
# タブを間違って閉じてしまっても、これをダブルクリック(または右クリックメニュー)するだけで
# ターミナルにコマンドを打たずにすぐ復帰できるようにする
LAUNCH_SEARCH="$HOME/.suiramu-launch-search.sh"
cat > "$LAUNCH_SEARCH" << EOF
#!/bin/bash
export DISPLAY=:1
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
"$CHROME_BIN" \\
  --no-sandbox --disable-gpu --disable-dev-shm-usage \\
  --start-maximized --window-position=0,0 --window-size=1280,800 \\
  --no-first-run --disable-infobars --force-color-profile=srgb \\
  --user-data-dir="$CHROME_PROFILE" \\
  "file://$REPO_DIR/home/search.html"
EOF
chmod +x "$LAUNCH_SEARCH"

LAUNCH_VIDEO="$HOME/.suiramu-launch-video.sh"
cat > "$LAUNCH_VIDEO" << EOF
#!/bin/bash
export DISPLAY=:1
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
"$CHROME_BIN" \\
  --no-sandbox --disable-gpu --disable-dev-shm-usage \\
  --start-maximized --window-position=0,0 --window-size=1280,800 \\
  --no-first-run --disable-infobars --autoplay-policy=no-user-gesture-required \\
  --user-data-dir="$HOME/.suiramu-chrome-profile-video" \\
  "file://$REPO_DIR/home/video.html"
EOF
chmod +x "$LAUNCH_VIDEO"

# ==== fluxboxの右クリックメニューに「Suiramuを開く」を登録 ====
mkdir -p "$HOME/.fluxbox"
cp -f .devcontainer/fluxbox-menu "$HOME/.fluxbox/menu"

echo "🪟 ウィンドウマネージャ起動中..."
fluxbox > /tmp/fluxbox.log 2>&1 &
sleep 1

# ==== 日本語入力(IME)を有効化 ====
# GTK/QtアプリがIMEを認識できるよう環境変数を設定してからfcitx5を起動
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx
if command -v fcitx5 > /dev/null 2>&1; then
  echo "⌨️  日本語入力(IME)を起動中..."
  fcitx5 --replace -d > /tmp/fcitx5.log 2>&1 &
  sleep 1
fi

echo "📡 VNCサーバー起動中..."
x11vnc -display :1 -forever -shared -nopw -quiet &
sleep 1

echo "🌐 noVNC 起動中（検索特化・高精細設定）..."
cp -f home/connect.html /opt/novnc/index.html 2>/dev/null || true
/opt/novnc/utils/novnc_proxy \
  --vnc localhost:5900 \
  --listen 6080 &
sleep 2

echo "🌏 ブラウザ起動中..."
bash "$LAUNCH_SEARCH" > /tmp/suiramu-chrome.log 2>&1 &

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
  echo "  💡 もしSuiramuのタブを間違って閉じてしまったら："
  echo "     画面の何もない場所を右クリック →"
  echo "     「Suiramu」→「🔍 Suiramuを開く（検索）」"
  echo "     で、ターミナル操作なしにすぐ復帰できます"
  echo ""
  echo "  💡 動画を見るなら Ctrl+C で止めて"
  echo "     npm run video を実行してください"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
fi

wait
