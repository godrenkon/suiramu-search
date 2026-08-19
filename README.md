# 📄 page

**制限されたネットワークでも世界中のサイトにアクセス可能にするツール**

![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-active-brightgreen)
![Built with](https://img.shields.io/badge/built%20with-GitHub%20Actions-blue)

---

## 🎯 ミッション

世界中の学生が、ネットワーク制限を理由に必要な情報にアクセスできない状況を変える。

**URL を入力するだけで、GitHub が自動的に世界中のサイトをアーカイブし、GitHub Pages で公開。どんな制限ネットワークからでもアクセス可能に。**

---

## ✨ 主な機能

| 機能 | 説明 |
|------|------|
| 🚀 **自動スクレイピング** | GitHub Actions が Puppeteer を使ってサイト全体を完全レンダリング |
| 🔒 **セキュア** | 端末側は通信ログが残らない。全て GitHub 側で処理 |
| 💾 **永続保存** | アーカイブ済みサイトは GitHub Pages で永遠に公開 |
| ⚡ **超高速** | 数分で URL → 公開サイトへ自動化 |
| 📦 **Zip 対応** | Codespaces やローカル環境でもダウンロード・利用可能 |
| 🌍 **多言語対応** | 世界中のサイトに対応 |

---

## 🚀 クイックスタート

### 1️⃣ 使い方（学生向け）

#### 方法A: GitHub Issues で URL を投稿（推奨）

1. **[GitHub Issues](https://github.com/godrenkon/page/issues)** を開く
2. **New Issue** をクリック
3. タイトルに「Archive Request」と入力
4. 本文に以下を記載：
   ```
   URL: https://example.com
   ```
5. **Submit new issue** をクリック
6. 数分後、GitHub Actions が自動実行
7. コメントで公開 URL が返される → クリックでアクセス！

#### 方法B: Web フォーム（今後追加予定）

https://godrenkon.github.io/page の入力フォームから直接リクエスト

---

### 2️⃣ アーカイブ済みサイトを見る

すべてのアーカイブ済みサイトは以下で公開中：

**https://godrenkon.github.io/page/archived-sites/**

---

### 3️⃣ ローカルで使う（Codespaces 対応）

```bash
# リポジトリをクローン
git clone https://github.com/godrenkon/page.git
cd page

# archived-sites/ フォルダ内のサイトをローカルサーバーで実行
cd archived-sites/example-domain
python -m http.server 8000

# ブラウザで http://localhost:8000 を開く
```

---

## 🛠️ 開発者向け

### セットアップ

```bash
# リポジトリをクローン
git clone https://github.com/godrenkon/page.git
cd page

# 依存関係をインストール
npm install

# ローカルでテスト
node scripts/archive.js https://example.com
```

### ワークフロー

```bash
# 手動でアーカイブをトリガー
gh workflow run archive.yml -f url="https://example.com"

# ログを確認
gh run list
gh run view [RUN_ID]
```

### フォルダ構成

```
page/
├── .github/
│   └── workflows/
│       └── archive.yml          # GitHub Actions ワークフロー
├── archived-sites/              # 生成されたアーカイブ（GitHub Pages で公開）
│   ├── example-domain/
│   │   ├── index.html          # アーカイブ済みサイト
│   │   ├── metadata.json       # メタデータ
│   │   └── README.md           # 説明
│   └── index.html              # サイトリスト
├── scripts/
│   └── archive.js              # スクレイピングスクリプト
├── index.html                  # 公式ランディングページ
├── package.json
└── README.md
```

---

## 🔧 技術スタック

| 技術 | 用途 |
|------|------|
| **GitHub Actions** | ワークフロー自動化 |
| **Puppeteer** | ブラウザ自動化＆スクレイピング |
| **Cheerio** | HTML パース |
| **GitHub Pages** | 静的サイトホスティング |
| **Node.js** | スクリプト実行 |

---

## ⚠️ 注意点

### 対応サイト
- ✅ 静的 HTML（ブログ、ニュースサイト）
- ✅ React/Vue/Angular（完全レンダリング）
- ✅ 画像、CSS、JavaScrip（全て含まれる）
- ❌ 認証が必要なサイト（ログイン後のみアクセス可能）
- ❌ リアルタイム更新が必須なサイト（Slack など）

### ライセンス・法律

- 📋 **著作権**: オリジナルコンテンツの著作権は元のサイト所有者に帰属
- 🎓 **用途**: 教育目的での利用に限定
- ⚖️ **利用規約**: 対象サイトの利用規約に従う

**このツールは教育的自由アクセスを目的としています。著作権侵害や違法な利用は禁止です。**

---

## 📊 統計情報

- ⭐ **アーカイブ済みサイト**: [リアルタイム](https://godrenkon.github.io/page/archived-sites/)
- 🌍 **対応国**: 全世界
- 👥 **ユーザー**: 世界中の学生
- ⚡ **処理時間**: 平均 2-5 分

---

## 🤝 コントリビューション

### バグ報告・機能リクエスト

[GitHub Issues](https://github.com/godrenkon/page/issues) で報告してください。

### コード貢献

1. Fork する
2. Feature ブランチを作成 (`git checkout -b feature/amazing`)
3. コミット (`git commit -m 'Add amazing feature'`)
4. Push (`git push origin feature/amazing`)
5. Pull Request を作成

---

## 📞 サポート

- 📧 **Email**: [renkomkun@gmail.com](mailto:renkomkun@gmail.com)
- 🐦 **Twitter**: [@Riku_verse_](https://x.com/Riku_verse_)
- 💬 **GitHub Discussions**: [page/discussions](https://github.com/godrenkon/page/discussions)

---

## 📄 ライセンス

このプロジェクトは [MIT License](LICENSE) の下でライセンスされています。

---

## 🙏 謝辞

- 世界中の学生のために
- GitHub Actions、Puppeteer、GitHub Pages
- すべてのコントリビューター

---

## 🚀 ロードマップ

- [ ] Web UI フォーム（自動 Issue 作成）
- [ ] API エンドポイント
- [ ] キャッシング機能（複数リクエスト対応）
- [ ] PDF/ePub エクスポート
- [ ] Telegram Bot 統合
- [ ] Discord Bot 統合
- [ ] モバイルアプリ

---

**Made with ❤️ for students worldwide.**

**「知る権利」は万国共通の基本的人権です。**

---

*最終更新: 2026年8月19日*
