<p align="right">
🌐 <a href="../README.md">日本語</a> | <a href="README.en.md">English</a> | <b>中文</b> | <a href="README.ko.md">한국어</a> | <a href="README.es.md">Español</a> | <a href="README.fr.md">Français</a>
</p>

# 🌐 Suiramu Search（S.S.）

**专为学生打造的学习访问环境，专注于「搜索」与「观看视频」**

Suiramu Search 在 GitHub Codespaces 上运行真正的 Chromium 浏览器，你通过它访问互联网。你自己的电脑上不需要安装任何东西，一切都在浏览器中完成。

![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-active-brightgreen)

---

## 🎯 这是什么？

Suiramu Search（简称 **S.S.**）拥有 **两种模式**，请根据用途选择启动。

| 模式 | 适用场景 | 特点 |
|---|---|---|
| 🔍 **搜索模式** | 查资料、写报告、阅读文章 | 文字清晰、运行轻快 |
| 🎬 **视频模式** | 观看 YouTube 等视频网站 | 画面流畅、带音频 |

与其在一个界面里兼顾所有功能，不如按用途切换模式，让每种模式都足够舒适好用。

---

## 🚀 使用方法（3 个步骤）

### 步骤 1：打开 Codespace

点击本页面的绿色 **「Code」** 按钮 → **「Codespaces」** 标签 → **「Create codespace on main」**

首次打开会自动开始配置环境（约 3～5 分钟）。

### 步骤 2：选择模式并启动

在屏幕下方的 **终端** 中输入以下命令之一，然后按 Enter。

**查资料、阅读文章时：**
```bash
npm run search
```

**看视频时：**
```bash
npm run video
```

### 步骤 3：打开画面

- 点击屏幕下方的 **「Ports」** 标签
- 点击 `6080` 那一行的地球图标（🌐）
- 新标签页会自动打开 Suiramu 的画面（不会出现连接设置画面）

**视频模式还需要多一个操作：**
- 请点击画面下方 **🔊 音频播放器** 的播放按钮一次
- （由于浏览器限制音频自动播放，第一次需要手动点击一下）

---

## 🔁 不小心关闭了 Suiramu 标签页怎么办

不需要回到终端重新输入命令。在画面空白处右键点击，会出现重新打开 Suiramu 的菜单。

```
右键 → Suiramu → 🔍 打开 Suiramu（搜索）
右键 → Suiramu → 🎬 打开 Suiramu（视频）
```

点击后即可立即重新打开 Suiramu 画面。后台服务（如数据保存）仍在运行，所以能立刻恢复到原来的状态。

---

## 🔄 想切换模式时

在终端按 `Ctrl + C` 停止当前模式，然后输入另一个命令。

```bash
# 从搜索模式切换到视频模式的例子
Ctrl + C            ← 停止当前模式
npm run video        ← 启动视频模式
```

---

## 🔍 搜索模式的功能

- 可在画面中央的搜索栏搜索，或直接输入网址打开页面
- 可从 **Google / Bing / DuckDuckGo / Wikipedia** 中选择搜索引擎（搜索栏上方的下拉菜单）
- 可将常用网站保存为图标（点击＋添加，右键删除）
- 多标签页与浏览历史可直接使用真实 Chromium 的功能
  - `Ctrl + T`：新标签页　`Ctrl + H`：历史记录　`Ctrl + Shift + T`：恢复关闭的标签页

---

## 🎬 视频模式的功能

- 一开始就提供 YouTube / Twitch / niconico / Vimeo 的快捷图标
- 画面传输设置已针对流畅播放视频进行优化
- 音频通过专用传输通道（Codespace 内的虚拟扬声器 → 音频流）播放
- 也可以在搜索栏中搜索视频（会跳转到 YouTube 搜索）

### 关于音频的坦诚说明

由于音频是通过网络传输的，因此**无法做到完全无延迟、绝不卡顿**。可能会有几百毫秒到 1 秒左右的延迟，网络状况不佳时也可能出现卡顿。不过已经调整到实用层面没有问题的程度。

如果画面或声音卡顿：
- 提升 Codespace 的机器配置可能会有所改善（`Settings → Codespaces → Machine type`）
- 适当降低视频网站本身的画质设置也有效

---

## 💾 关于数据保存（GitHub 账号关联）

保存的网站（书签）会自动存储在**你专属的私有仓库** `<你的用户名>/suiramu-data` 中。

- 首次启动时会自动创建该仓库（Private）
- 添加新网站后，几秒钟内会自动保存到该仓库
- 即使新建其他 Codespace，也会自动读取同一份数据
- 不会输入或保存任何邮箱地址或密码（只是复用 Codespace 中已有的 GitHub 认证）

---

## 🌍 支持的语言

可通过右上角的下拉菜单切换界面显示语言：

🇯🇵 日本語 / 🇺🇸 English / 🇨🇳 中文 / 🇰🇷 한국어 / 🇪🇸 Español / 🇫🇷 Français

如果想翻译正在浏览的外部网站本身，可以使用 Chromium 自带的翻译功能（右键点击页面 →「翻译」）。

### 关于日语、中文、韩语等的输入

默认情况下只能输入英数字。如果想输入日语、中文等需要转换的语言，请在 Codespace 终端中**执行一次对应语言的命令**。输入法框架本身（fcitx5）已经预装，只需要额外添加对应语言的转换引擎。

| 语言 | 需在终端执行的命令 |
|---|---|
| 🇯🇵 日语 | `sudo apt-get install -y fcitx5-mozc` |
| 🇨🇳 中文（简体） | `sudo apt-get install -y fcitx5-pinyin` |
| 🇹🇼 中文（繁體） | `sudo apt-get install -y fcitx5-chewing` |
| 🇰🇷 韩语 | `sudo apt-get install -y fcitx5-hangul` |
| 🇻🇳 越南语 | `sudo apt-get install -y fcitx5-unikey` |
| 🇹🇭 泰语 | `sudo apt-get install -y fcitx5-libthai` |

安装后，再次执行 `npm run search`（或 `video`）即可开始使用。

**使用方法（各语言通用）：**
- 点击输入框输入内容，会自动出现转换候选词
- 使用半角/全角键，或 `Ctrl + Space` 切换输入法开关

上表未列出的语言，通常也能找到以 `fcitx5-` 开头的软件包。可在终端中这样搜索：

```bash
apt-cache search fcitx5
```

---

## ✉️ 联系我们 / 意见反馈

在侧边菜单的「联系我们 / 意见反馈」中，可通过简单的表单发送消息。提交后会打开 GitHub Issue 创建页面（需要 GitHub 账号）。

如果想直接发布，请点击[这里](https://github.com/godrenkon/suiramu-search/issues/new/choose)。

---

## 🔒 关于隐私

- 「账户」图标只是一个简单的显示名称设置，仅保存在你 Codespace 内的浏览器中
- 保存网站的数据存储在你自己 GitHub 账号下的私有仓库中，绝不会发送到 Suiramu 项目运营方的任何服务器
- 绝不会要求输入邮箱地址或密码

---

## 🛠️ 技术构成（感兴趣的人可以看看）

| 技术 | 作用 |
|---|---|
| GitHub Codespaces | 运行环境（你专属的一次性电脑） |
| Xvfb | 虚拟显示器 |
| Chromium | 实际运行的浏览器本体 |
| x11vnc + noVNC | 将画面传输到你的网页浏览器 |
| PulseAudio + ffmpeg | 视频模式下的音频流传输 |
| GitHub CLI (`gh`) | 用于持久化保存书签（使用你自己的私有仓库） |

搜索模式与视频模式通过调整 noVNC/x11vnc 的压缩设置（在画质与帧率之间取得平衡），分别针对各自的用途进行了优化。

---

## ⚠️ 常见问题

**Q. 打开 6080 端口后，出现的不是 Chromium，而是空白的桌面画面**
A. 主要有两个原因。

1. **在执行 `npm run search` 或 `npm run video` 之前就打开了端口** — Suiramu 的画面只有在执行命令后才会出现。请先在终端执行命令，再打开端口标签。
2. **浏览器启动失败** — 请在终端执行以下命令，查看是否有报错。
   ```bash
   cat /tmp/suiramu-chrome.log
   ```
   如果没有任何显示或出现报错，请尝试重新执行配置。
   ```bash
   npm run setup
   ```

**Q. 显示「未找到 GitHub 认证」**
A. 这是在找不到自动保存书签（保存到你的私有仓库）所需认证时出现的提示。功能本身不受影响，此时书签会暂时保存在 Codespace 内。如果想启用持久化保存，请在终端尝试：
   ```bash
   gh auth login
   ```
   之后再次执行 `npm run search`（或 `video`）。

**Q. 想同时使用搜索和视频模式**
A. 目前一个 Codespace 只能运行一种模式。如果想同时使用两种模式，请在浏览器中再打开一个 Codespace，在那里启动另一种模式（请注意 GitHub 免费额度的限制）。

**Q. Codespace 的使用时间有限制吗？**
A. 这取决于你的 GitHub 账号类型。详情请查看 GitHub 的设置页面。

**Q. 可以使用需要登录的网站（如学校门户）吗？**
A. 可以。由于运行的是真实的 Chromium 浏览器，你可以像平常一样登录并使用。

---

## 📞 支持

- 🐛 问题反馈 / 功能建议：[Issues](https://github.com/godrenkon/suiramu-search/issues/new/choose)

---

*为只想搜索和看视频、不想折腾的学生们而做。*
