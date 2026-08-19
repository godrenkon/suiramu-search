#!/bin/bash

echo "🚀 Suiramu Browser 起動準備中..."

# 既存プロセスをクリーンアップ
pkill Xvfb 2>/dev/null || true
pkill x11vnc 2>/dev/null || true
pkill fluxbox 2>/dev/null || true
pkill -f websockify 2>/dev/null || true
pkill -f chromium 2>/dev/null || true
pkill -f "node .devcontainer/server.js" 2>/dev/null || true
sleep 1

# 0. ブックマークデータをGitHub(プライベートリポジトリ)と同期
bash .devcontainer/sync_data.sh

# 0.5 ブックマーク保存用のローカルAPIサーバーを起動
echo "📡 データサーバー起動中..."
node .devcontainer/server.js > /tmp/suiramu-server.log 2>&1 &
sleep 1

# 1. 仮想ディスプレイ起動 (画面番号 :1, 解像度1280x800)
echo "🖥️  仮想ディスプレイ起動中..."
Xvfb :1 -screen 0 1280x800x24 &
sleep 2

export DISPLAY=:1

# 2. 軽量ウィンドウマネージャ起動
echo "🪟 ウィンドウマネージャ起動中..."
fluxbox &
sleep 1

# 3. VNCサーバー起動（パスワードなし・ローカル限定なので許容）
echo "📡 VNCサーバー起動中..."
x11vnc -display :1 -forever -shared -nopw -quiet &
sleep 1

# 4. noVNC (Webブラウザで見れるように変換) をポート6080で起動
echo "🌐 noVNC 起動中（ポート6080）..."
/opt/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 6080 &
sleep 2

# 5. Chromium 起動
#    --user-data-dir を固定ディレクトリにすることで、
#    タブの状態・閲覧履歴・ブックマークバー等が Codespace 再起動をまたいでも保持される
#    --restore-last-session で、閉じたときのタブ構成を次回も復元
CHROME_PROFILE="$HOME/.suiramu-chrome-profile"
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
  --user-data-dir="$CHROME_PROFILE" \
  --restore-last-session \
  "file://$(pwd)/home/index.html" &

echo ""
echo "✅ 起動完了！"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Codespace の「ポート」タブを開いて"
echo "  6080番ポートのURLをクリックしてください"
echo ""
echo "  💡 Ctrl+T で新しいタブ、Ctrl+H で履歴が見れます"
echo "  💡 ブックマークはあなた専用のプライベート"
echo "     リポジトリ(suiramu-data)に自動保存されます"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# プロセスを維持
wait
