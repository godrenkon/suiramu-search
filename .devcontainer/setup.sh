#!/bin/bash
set -e

echo "🔧 Suiramu Browser セットアップ開始..."

# パッケージリスト更新
sudo apt-get update -qq

echo "📦 必要パッケージをインストール中（少し時間がかかります）..."

# 仮想ディスプレイ + VNC + 日本語フォント + Chromium
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
  > /dev/null 2>&1

echo "✅ システムパッケージ完了"

# noVNC のインストール
echo "📥 noVNC をダウンロード中..."
if [ ! -d "/opt/novnc" ]; then
  sudo git clone --depth 1 https://github.com/novnc/noVNC.git /opt/novnc > /dev/null 2>&1
  sudo git clone --depth 1 https://github.com/novnc/websockify /opt/novnc/utils/websockify > /dev/null 2>&1
fi
echo "✅ noVNC 完了"

# Node.js 依存関係
echo "📦 Node.js パッケージをインストール中..."
npm install --silent

echo ""
echo "🎉 セットアップ完了！"
echo ""
echo "次のコマンドで起動できます:"
echo "  npm start"
echo ""
