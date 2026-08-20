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
  ffmpeg \
  ca-certificates \
  libnss3 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libcups2 \
  libdrm2 \
  libxkbcommon0 \
  libxcomposite1 \
  libxdamage1 \
  libxfixes3 \
  libxrandr2 \
  libgbm1 \
  libasound2t64 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libatspi2.0-0 \
  libgtk-3-0t64 \
  > /dev/null 2>&1 || sudo apt-get install -y -qq \
  xvfb \
  x11vnc \
  fluxbox \
  fonts-noto-cjk \
  git \
  wget \
  net-tools \
  supervisor \
  pulseaudio \
  ffmpeg \
  ca-certificates \
  libnss3 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libcups2 \
  libdrm2 \
  libxkbcommon0 \
  libxcomposite1 \
  libxdamage1 \
  libxfixes3 \
  libxrandr2 \
  libgbm1 \
  libasound2 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libatspi2.0-0 \
  libgtk-3-0 \
  > /dev/null 2>&1

echo "✅ 基本パッケージ完了"

# ==== 日本語入力(IME)のインストール ====
# fcitx5 + Mozc で、Xvfb内のアプリ(Chromium含む)から日本語入力できるようにする
echo "📦 日本語入力(IME)をインストール中..."
sudo apt-get install -y -qq \
  fcitx5 \
  fcitx5-mozc \
  fcitx5-config-qt \
  > /dev/null 2>&1 || echo "⚠️  日本語入力のインストールに一部失敗しました（英数字入力は引き続き可能です）"
echo "✅ 日本語入力の準備完了"

# ==== Chromium本体のインストール ====
# Ubuntu の "chromium" / "chromium-browser" apt パッケージは、
# バージョンによっては実体を持たない snap 転送ラッパーになっており、
# Codespace(コンテナ環境, snapd なし)では実行できないことがある。
# そのため、Puppeteer 経由で snap に依存しない Chromium 本体を確実に取得する。
echo "📦 Node.js パッケージをインストール中..."
npm install --silent

echo "📦 Chromium 本体を取得中（Puppeteer経由・snap不要）..."
if [ ! -d "node_modules/puppeteer" ]; then
  npm install puppeteer --silent
fi

# Puppeteerがダウンロードした実際のChromium実行ファイルのパスを取得
CHROME_PATH=$(node -e "console.log(require('puppeteer').executablePath())" 2>/dev/null || echo "")

if [ -z "$CHROME_PATH" ] || [ ! -f "$CHROME_PATH" ]; then
  echo "❌ Chromiumの取得に失敗しました。セットアップを中断します。"
  exit 1
fi

echo "$CHROME_PATH" > /tmp/suiramu-chrome-bin
echo "✅ Chromium 本体: $CHROME_PATH"

echo "📥 noVNC をダウンロード中..."
if [ ! -d "/opt/novnc" ]; then
  sudo git clone --depth 1 https://github.com/novnc/noVNC.git /opt/novnc > /dev/null 2>&1
  sudo git clone --depth 1 https://github.com/novnc/websockify /opt/novnc/utils/websockify > /dev/null 2>&1
fi
echo "✅ noVNC 完了"

echo ""
echo "🎉 セットアップ完了！"
echo ""
echo "次のどちらかのコマンドで起動できます:"
echo "  npm run search   … 検索特化モード（文字がくっきり、軽量）"
echo "  npm run video    … 動画特化モード（映像なめらか、音声つき）"
echo ""
