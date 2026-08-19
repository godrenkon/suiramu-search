// ブックマークの保存だけを担当する、超軽量なローカルAPIサーバー
// 依存パッケージなし（Node.js標準機能のみ）で動かして、セットアップを軽くしている
// GitHubへの実際の保存(commit/push)は sync_data.sh 側と、この定期pushで行う

const http = require('http');
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const os = require('os');

const DATA_DIR = path.join(os.homedir(), '.suiramu-data');
const BOOKMARKS_FILE = path.join(DATA_DIR, 'bookmarks.json');
const PORT = 7070;

function readBookmarks() {
  try {
    return JSON.parse(fs.readFileSync(BOOKMARKS_FILE, 'utf8'));
  } catch {
    return [];
  }
}

function writeBookmarks(data) {
  fs.mkdirSync(DATA_DIR, { recursive: true });
  fs.writeFileSync(BOOKMARKS_FILE, JSON.stringify(data, null, 2));
}

// GitHubへ非同期でpush（失敗してもローカル保存は残るので安全）
let pushTimer = null;
function schedulePush() {
  clearTimeout(pushTimer);
  pushTimer = setTimeout(() => {
    try {
      execSync('git add bookmarks.json && git commit -m "Update bookmarks" --quiet && git push --quiet', {
        cwd: DATA_DIR,
        stdio: 'ignore'
      });
      console.log('✅ GitHubへ保存しました');
    } catch (e) {
      // 変更がない場合や、認証未設定の場合はここに来る。致命的ではないので握りつぶす
    }
  }, 3000); // 3秒デバウンス（連続保存の連打を1回にまとめる）
}

const server = http.createServer((req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,OPTIONS');

  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    return res.end();
  }

  if (req.url === '/bookmarks' && req.method === 'GET') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    return res.end(JSON.stringify(readBookmarks()));
  }

  if (req.url === '/bookmarks' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        const data = JSON.parse(body);
        writeBookmarks(data);
        schedulePush();
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ ok: true }));
      } catch (e) {
        res.writeHead(400);
        res.end(JSON.stringify({ ok: false, error: e.message }));
      }
    });
    return;
  }

  res.writeHead(404);
  res.end('Not found');
});

server.listen(PORT, '127.0.0.1', () => {
  console.log(`📡 Suiramu data server: http://127.0.0.1:${PORT}`);
});
