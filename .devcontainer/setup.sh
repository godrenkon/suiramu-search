#!/bin/bash
set -e

echo "🔧 Suiramu セットアップ開始..."

sudo apt-get update -qq

echo "📦 必要パッケージをインストール中（少し時間がかかります）..."

sudo apt-get install -y -qq \
  xvfb \
  x11vnc \
  fluxbox \
  chromium-browser \
  fonts-noto-cjk \
  git \
  wget \
  net-tools \
  supervisor \
  pulseaudio \
  ffmpeg \
  > /dev/null 2>&1

echo "✅ システムパッケージ完了"

echo "📥 noVNC をダウンロード中..."
if [ ! -d "/opt/novnc" ]; then
  sudo git clone --depth 1 https://github.com/novnc/noVNC.git /opt/novnc > /dev/null 2>&1
  sudo git clone --depth 1 https://github.com/novnc/websockify /opt/novnc/utils/websockify > /dev/null 2>&1
fi
echo "✅ noVNC 完了"

echo "📦 Node.js パッケージをインストール中..."
npm install --silent

echo ""
echo "🎉 セットアップ完了！"
echo ""
echo "次のどちらかのコマンドで起動できます:"
echo "  npm run search   … 検索特化モード（文字がくっきり、軽量）"
echo "  npm run video    … 動画特化モード（映像なめらか、音声つき）"
echo ""
