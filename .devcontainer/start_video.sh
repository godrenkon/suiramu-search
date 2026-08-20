#!/bin/bash

echo "🎬 Suiramu【動画特化モード】起動準備中..."

pkill Xvfb 2>/dev/null || true
pkill x11vnc 2>/dev/null || true
pkill fluxbox 2>/dev/null || true
pkill -f websockify 2>/dev/null || true
pkill -f chrome 2>/dev/null || true
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

CHROME_PROFILE="$HOME/.suiramu-chrome-profile-video"
mkdir -p "$CHROME_PROFILE"
REPO_DIR="$(pwd)"

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
  --user-data-dir="$HOME/.suiramu-chrome-profile-search" \\
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
  --user-data-dir="$CHROME_PROFILE" \\
  "file://$REPO_DIR/home/video.html"
EOF
chmod +x "$LAUNCH_VIDEO"

mkdir -p "$HOME/.fluxbox"
cp -f .devcontainer/fluxbox-menu "$HOME/.fluxbox/menu"

echo "🪟 ウィンドウマネージャ起動中..."
fluxbox > /tmp/fluxbox.log 2>&1 &
sleep 1

# ==== 日本語入力(IME)を有効化 ====
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx
if command -v fcitx5 > /dev/null 2>&1; then
  echo "⌨️  日本語入力(IME)を起動中..."
  fcitx5 --replace -d > /tmp/fcitx5.log 2>&1 &
  sleep 1
fi

echo "🔊 音声デバイスをセットアップ中..."
pulseaudio --start --exit-idle-time=-1 > /tmp/pulseaudio.log 2>&1
sleep 1
pactl load-module module-null-sink sink_name=suiramu_speaker sink_properties=device.description=SuiramuSpeaker > /dev/null 2>&1 || true
pactl set-default-sink suiramu_speaker > /dev/null 2>&1 || true
echo "✅ 音声デバイス準備完了"

echo "🔊 音声ストリーミングサーバー起動中..."
node .devcontainer/audio_server.js > /tmp/suiramu-audio.log 2>&1 &
sleep 1

echo "🌐 noVNC 起動中（動画特化・なめらか設定）..."
cp -f home/connect.html /opt/novnc/index.html 2>/dev/null || true
/opt/novnc/utils/novnc_proxy \
  --vnc localhost:5900 \
  --listen 6080 &
sleep 1

pkill x11vnc 2>/dev/null || true
x11vnc -display :1 -forever -shared -nopw -quiet -ncache 10 -wait 5 &
sleep 1

echo "🌏 ブラウザ起動中..."
bash "$LAUNCH_VIDEO" > /tmp/suiramu-chrome.log 2>&1 &

sleep 4

# bashラッパーのPIDではなく、実際にChromiumプロセスが立っているかを確認する
# (CHROME_BINのファイル名でプロセス一覧を検索)
CHROME_PROC_NAME=$(basename "$CHROME_BIN")
if ! pgrep -f "$CHROME_PROC_NAME" > /dev/null 2>&1; then
  echo ""
  echo "❌ ブラウザの起動に失敗しました。"
  echo "───────────────────────────────"
  echo "エラーログ (/tmp/suiramu-chrome.log):"
  cat /tmp/suiramu-chrome.log 2>/dev/null | tail -20
  echo "───────────────────────────────"
  echo ""
else
  echo ""
  echo "✅ 起動完了！【動画特化モード】"
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  ① 映像: 「ポート」タブから 6080番 を開く"
  echo "     （自動でSuiramuの画面に接続されます）"
  echo "  ② 音声: 開いた画面の下部にある"
  echo "     🔊 音声プレーヤー の再生ボタンを押す"
  echo ""
  echo "  💡 もしSuiramuのタブを間違って閉じてしまったら："
  echo "     画面の何もない場所を右クリック →"
  echo "     「Suiramu」→「🎬 Suiramuを開く（動画）」"
  echo "     で、ターミナル操作なしにすぐ復帰できます"
  echo ""
  echo "  💡 文字を読む作業がメインなら Ctrl+C で止めて"
  echo "     npm run search を実行してください"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
fi

wait
