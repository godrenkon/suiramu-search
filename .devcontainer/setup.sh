#!/bin/bash
set -e

echo "🔧 Suiramu セットアップ開始..."

# Codespace起動直後は、裏側で別のapt-get/dpkgプロセスがまだ動いている場合がある。
# 特殊なコマンド(fuser等、環境によって無いことがある)には依存せず、
# apt-get自体を実行してみてロックエラーなら少し待ってリトライする方式にする。
echo "⏳ パッケージマネージャの空きを確認中..."
UPDATE_OK=0
for attempt in 1 2 3 4 5 6 7 8 9 10; do
  if sudo apt-get update -qq 2>/tmp/suiramu-apt-error.log; then
    UPDATE_OK=1
    break
  fi
  if grep -q "Could not get lock\|dpkg frontend lock\|Unable to acquire" /tmp/suiramu-apt-error.log 2>/dev/null; then
    sleep 3
    continue
  fi
  # ロック以外の理由での失敗は、そのまま表示して次に進む(update自体は必須ではない)
  break
done
if [ "$UPDATE_OK" -eq 0 ]; then
  echo "⚠️  apt-get update に時間がかかっています。そのまま続行します。"
  cat /tmp/suiramu-apt-error.log 2>/dev/null
fi

echo "📦 必要パッケージをインストール中（少し時間がかかります）..."

# Ubuntuのバージョンによってパッケージ名(t64サフィックスの有無など)が異なることがあるため、
# 1つずつ個別にインストールし、失敗したものだけ代替名を試す。
# 全体を1コマンドにまとめて丸ごと失敗させる(かつエラーを隠す)構成はもう使わない。
install_pkg() {
  local primary="$1"
  local fallback="$2"
  local attempt

  for attempt in 1 2 3; do
    if sudo apt-get install -y -qq "$primary" 2>/tmp/suiramu-apt-error.log; then
      return 0
    fi
    if grep -q "Could not get lock\|dpkg frontend lock" /tmp/suiramu-apt-error.log 2>/dev/null; then
      sleep 3
      continue
    fi
    break
  done

  if [ -n "$fallback" ] && sudo apt-get install -y -qq "$fallback" 2>/tmp/suiramu-apt-error.log; then
    return 0
  fi
  echo "⚠️  パッケージ '$primary' のインストールに失敗しました（続行します）"
  cat /tmp/suiramu-apt-error.log
  return 1
}

install_pkg xvfb
install_pkg x11vnc
install_pkg fluxbox
install_pkg fonts-noto-cjk
install_pkg git
install_pkg wget
install_pkg net-tools
install_pkg supervisor
install_pkg pulseaudio
install_pkg ffmpeg
install_pkg ca-certificates
install_pkg libnss3
install_pkg libatk1.0-0
install_pkg libatk-bridge2.0-0
install_pkg libcups2
install_pkg libdrm2
install_pkg libxkbcommon0
install_pkg libxcomposite1
install_pkg libxdamage1
install_pkg libxfixes3
install_pkg libxrandr2
install_pkg libgbm1
install_pkg libasound2t64 libasound2
install_pkg libpango-1.0-0
install_pkg libpangocairo-1.0-0
install_pkg libatspi2.0-0
install_pkg libgtk-3-0t64 libgtk-3-0

echo "✅ 基本パッケージ完了"

# ==== 入力システム(IME)の土台をインストール ====
echo "📦 入力システム(IME)の土台をインストール中..."
install_pkg fcitx5
install_pkg fcitx5-config-qt
echo "✅ 入力システムの準備完了"

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

# Puppeteerのpostinstallでダウンロードされない場合に備えて、明示的にも取得しておく
echo "📥 Chromium バイナリをダウンロード中..."
npx --yes puppeteer browsers install chrome 2>&1 | tee /tmp/puppeteer-install.log

# Puppeteerがダウンロードした実際のChromium実行ファイルのパスを取得
# (executablePath()は非同期関数のため、Promiseを正しく待つ)
CHROME_PATH=$(node -e "
require('puppeteer').executablePath().then(p => {
  console.log(p);
}).catch(err => {
  console.error(err.message);
  process.exit(1);
});
" 2>/tmp/suiramu-chrome-path-error.log)

if [ -z "$CHROME_PATH" ] || [ ! -f "$CHROME_PATH" ]; then
  echo "❌ Chromiumの取得に失敗しました。"
  echo "エラー内容:"
  cat /tmp/suiramu-chrome-path-error.log
  echo "---"
  echo "Puppeteerインストールログ:"
  cat /tmp/puppeteer-install.log
  exit 1
fi

echo "$CHROME_PATH" > /tmp/suiramu-chrome-bin
echo "✅ Chromium 本体: $CHROME_PATH"

# ==== 仮想ディスプレイ用ディレクトリを事前準備 ====
# 非rootユーザーだと /tmp/.X11-unix を自動作成できず
# 「_XSERVTransmkdir: ERROR: euid != 0」で失敗することがあるため、事前にsudoで用意しておく
echo "🖥️  ディスプレイ用ディレクトリを準備中..."
sudo mkdir -p /tmp/.X11-unix
sudo chmod 1777 /tmp/.X11-unix
echo "✅ 準備完了"

echo "📥 noVNC をダウンロード中..."
if [ ! -d "/opt/novnc" ]; then
  sudo git clone --depth 1 https://github.com/novnc/noVNC.git /opt/novnc
  sudo git clone --depth 1 https://github.com/novnc/websockify /opt/novnc/utils/websockify
fi
sudo chmod -R a+rX /opt/novnc
echo "✅ noVNC 完了"

echo ""
echo "🎉 セットアップ完了！"
echo ""
echo "次のどちらかのコマンドで起動できます:"
echo "  npm run search   … 検索特化モード（文字がくっきり、軽量）"
echo "  npm run video    … 動画特化モード（映像なめらか、音声つき）"
echo ""
