#!/bin/bash

echo "🎬 Suiramu【動画特化モード】起動準備中..."

pkill Xvfb 2>/dev/null || true
pkill x11vnc 2>/dev/null || true
pkill fluxbox 2>/dev/null || true
pkill -f websockify 2>/dev/null || true
pkill -f chromium 2>/dev/null || true
pkill -f "node .devcontainer/server.js" 2>/dev/null || true
pkill -f "node .devcontainer/audio_server.js" 2>/dev/null || true
pkill pulseaudio 2>/dev/null || true
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

# ==== 音声セットアップ: 仮想スピーカーを作成 ====
echo "🔊 音声デバイスをセットアップ中..."
pulseaudio --start --exit-idle-time=-1 > /tmp/pulseaudio.log 2>&1
sleep 1
# suiramu_speaker という名前の仮想スピーカーを作成
# Chromiumの音声出力先をここにすることで、後段のffmpegが拾える
pactl load-module module-null-sink sink_name=suiramu_speaker sink_properties=device.description=SuiramuSpeaker > /dev/null 2>&1 || true
pactl set-default-sink suiramu_speaker > /dev/null 2>&1 || true
echo "✅ 音声デバイス準備完了"

echo "🔊 音声ストリーミングサーバー起動中..."
node .devcontainer/audio_server.js > /tmp/suiramu-audio.log 2>&1 &
sleep 1

# ==== 動画特化: なめらかさ優先の圧縮設定 ====
# JPEG品質を下げてでもフレームレートを稼ぐ設定
echo "🌐 noVNC 起動中（動画特化・なめらか設定）..."
/opt/novnc/utils/novnc_proxy \
  --vnc localhost:5900 \
  --listen 6080 &
sleep 1

# x11vnc は動画向けに ncache や品質パラメータを調整して起動
pkill x11vnc 2>/dev/null || true
x11vnc -display :1 -forever -shared -nopw -quiet -ncache 10 -wait 5 &
sleep 1

CHROME_PROFILE="$HOME/.suiramu-chrome-profile-video"
mkdir -p "$CHROME_PROFILE"

# setup.sh が確認したChromiumの実行コマンド名を使う（なければその場で判定）
if [ -f /tmp/suiramu-chrome-bin ]; then
  CHROME_BIN=$(cat /tmp/suiramu-chrome-bin)
elif command -v chromium-browser > /dev/null 2>&1; then
  CHROME_BIN="chromium-browser"
elif command -v chromium > /dev/null 2>&1; then
  CHROME_BIN="chromium"
else
  echo ""
  echo "❌ Chromiumが見つかりません。"
  echo "   npm run setup を実行してセットアップをやり直してください。"
  echo ""
  exit 1
fi

echo "🌏 ブラウザ起動中（$CHROME_BIN）..."
"$CHROME_BIN" \
  --no-sandbox \
  --disable-gpu \
  --disable-dev-shm-usage \
  --start-maximized \
  --window-position=0,0 \
  --window-size=1280,800 \
  --no-first-run \
  --disable-infobars \
  --autoplay-policy=no-user-gesture-required \
  --user-data-dir="$CHROME_PROFILE" \
  --restore-last-session \
  "file://$(pwd)/home/video.html" \
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
  echo "✅ 起動完了！【動画特化モード】"
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  ① 映像: 「ポート」タブから 6080番 を開く"
  echo "  ② 音声: 開いた画面の下部にある"
  echo "     🔊 音声プレーヤー の再生ボタンを押す"
  echo "     （ブラウザの仕様上、自動再生できないため"
  echo "      最初の1回だけ手動で押す必要があります）"
  echo ""
  echo "  💡 文字を読む作業がメインなら Ctrl+C で止めて"
  echo "     npm run search を実行してください"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
fi

wait
