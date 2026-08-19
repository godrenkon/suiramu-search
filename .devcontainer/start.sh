#!/bin/bash

echo "🚀 Suiramu Browser 起動準備中..."

# 既存プロセスをクリーンアップ
pkill Xvfb 2>/dev/null || true
pkill x11vnc 2>/dev/null || true
pkill fluxbox 2>/dev/null || true
pkill -f websockify 2>/dev/null || true
pkill -f chromium 2>/dev/null || true
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

# 5. Chromium をフルスクリーンで起動（最初は検索エンジンのトップページ）
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
  "file://$(pwd)/home/index.html" &

echo ""
echo "✅ 起動完了！"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Codespace の「ポート」タブを開いて"
echo "  6080番ポートのURLをクリックしてください"
echo "  （自動でブラウザが開く場合もあります）"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# プロセスを維持
wait
