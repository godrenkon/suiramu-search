// 動画特化モード専用: Codespace内で鳴っている音声を、
// ブラウザで再生できる形でストリーミング配信する軽量サーバー
//
// 仕組み:
//   PulseAudio仮想スピーカー(Chromiumの音はここに出力される)
//     → ffmpeg が録音しつつ Opus/WebM 形式に変換
//     → このサーバーがその出力をHTTPで垂れ流し配信(ポート7071)
//     → ブラウザの <audio> タグがそれを再生
//
// 遅延はどうしても数百ms〜1秒程度出ますが、実用上問題ない範囲を狙っています。

const http = require('http');
const { spawn } = require('child_process');

const PORT = 7071;
let ffmpegProc = null;
const clients = new Set();

function startFfmpeg() {
  if (ffmpegProc) return;

  // PulseAudioの仮想モニターデバイスから録音し、低遅延Opusエンコードでストリーム出力
  ffmpegProc = spawn('ffmpeg', [
    '-f', 'pulse',
    '-i', 'suiramu_speaker.monitor',
    '-ac', '2',
    '-ar', '48000',
    '-c:a', 'libopus',
    '-b:a', '96k',
    '-f', 'webm',
    '-flush_packets', '1',
    'pipe:1'
  ]);

  ffmpegProc.stdout.on('data', (chunk) => {
    for (const res of clients) {
      res.write(chunk);
    }
  });

  ffmpegProc.stderr.on('data', () => {
    // ffmpegのログは無視（デバッグ時のみ表示したい場合はここでconsole.logする）
  });

  ffmpegProc.on('close', () => {
    ffmpegProc = null;
  });
}

const server = http.createServer((req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');

  if (req.url === '/audio') {
    res.writeHead(200, {
      'Content-Type': 'audio/webm',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Transfer-Encoding': 'chunked'
    });

    clients.add(res);
    startFfmpeg();

    req.on('close', () => {
      clients.delete(res);
      // 誰も聞いていなければffmpegを止めて負荷を減らす
      if (clients.size === 0 && ffmpegProc) {
        ffmpegProc.kill('SIGTERM');
        ffmpegProc = null;
      }
    });
    return;
  }

  if (req.url === '/status') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ listeners: clients.size, running: !!ffmpegProc }));
    return;
  }

  res.writeHead(404);
  res.end('Not found');
});

server.listen(PORT, '127.0.0.1', () => {
  console.log(`🔊 Suiramu audio stream: http://127.0.0.1:${PORT}/audio`);
});
