#!/bin/bash
set -e

echo "🔧 Suiramu セットアップ開始..."

sudo apt-get update -qq

echo "📦 必要パッケージをインストール中（少し時間がかかります）..."

sudo apt-get install -y -qq \
  xvfb \
  x11vnc \
  fluxbox \
  fonts-noto-cjk \
  git \
  wget \
  net-tools \
  supervisor \
  pulseaudio \
  ffmpeg

echo "✅ 基本パッケージ完了"

# ==== Chromium本体のインストール ====
# Ubuntu 22.04の "chromium-browser" は snap 経由のラッパーで、
# Codespace(コンテナ環境, snapdなし)では正しくインストールできないことがある。
# そのため、実体を含む "chromium" パッケージを優先し、失敗したら明確にエラー表示する。
echo "📦 Chromium 本体をインストール中..."
if sudo apt-get install -y -qq chromium; then
  CHROME_BIN="chromium"
elif sudo apt-get install -y -qq chromium-browser; then
  CHROME_BIN="chromium-browser"
else
  echo "❌ Chromiumのインストールに失敗しました。セットアップを中断します。"
  exit 1
fi

# 実際に使えるコマンド名を確認して記録しておく（起動スクリプト側で参照する）
if command -v chromium-browser > /dev/null 2>&1; then
  echo "chromium-browser" > /tmp/suiramu-chrome-bin
elif command -v chromium > /dev/null 2>&1; then
  echo "chromium" > /tmp/suiramu-chrome-bin
else
  echo "❌ Chromiumの実行ファイルが見つかりません。セットアップを中断します。"
  exit 1
fi
echo "✅ Chromium 本体: $(cat /tmp/suiramu-chrome-bin)"

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
