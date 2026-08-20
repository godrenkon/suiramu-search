<p align="right">
🌐 <a href="../README.md">日本語</a> | <b>English</b> | <a href="README.zh.md">中文</a> | <a href="README.ko.md">한국어</a> | <a href="README.es.md">Español</a> | <a href="README.fr.md">Français</a>
</p>

# 🌐 Suiramu Search (S.S.)

**A learning-access environment for students, built entirely around "search" and "watching videos"**

Suiramu Search runs a real Chromium browser on GitHub Codespaces and lets you access the internet through it. Nothing is installed on your own computer — everything runs in the browser.

![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-active-brightgreen)

---

## 🎯 What is this?

Suiramu Search (**S.S.** for short) has **two modes**. Pick whichever fits what you're doing.

| Mode | Use it for | Optimized for |
|---|---|---|
| 🔍 **Search mode** | Research, writing reports, reading | Crisp text, lightweight |
| 🎬 **Video mode** | Watching YouTube and similar sites | Smooth video, with audio |

Rather than trying to do everything in one screen, Suiramu switches between modes so each one can be genuinely comfortable to use.

---

## 🚀 How to use it (3 steps)

### Step 1: Open a Codespace

Click the green **"Code"** button on this page → **"Codespaces"** tab → **"Create codespace on main"**

Setup runs automatically the first time (about 3-5 minutes).

### Step 2: Start a mode

In the terminal at the bottom of the screen, type one of the following and press Enter.

**For research and reading:**
```bash
npm run search
```

**For watching videos:**
```bash
npm run video
```

### Step 3: Open the screen

- Click the **"Ports"** tab near the bottom of the screen
- Click the globe icon (🌐) on the `6080` row
- A new tab opens showing Suiramu automatically (no connection setup screen)

**Video mode needs one extra step:**
- Press the play button on the **🔊 audio player** near the bottom of the screen once
- (Browsers block audio autoplay, so this one manual click is required the first time)

---

## 🔁 If you accidentally close the Suiramu tab

You don't need to go back to the terminal and retype anything. Right-click anywhere on the empty background and a menu to reopen Suiramu will appear.

```
Right-click → Suiramu → 🔍 Open Suiramu (Search)
Right-click → Suiramu → 🎬 Open Suiramu (Video)
```

Clicking this reopens the Suiramu screen instantly. The background services (like data saving) keep running, so you're right back where you left off.

---

## 🔄 Switching modes

Press `Ctrl + C` in the terminal to stop the current mode, then run the other command.

```bash
# Example: switching from search mode to video mode
Ctrl + C            ← stop the current mode
npm run video        ← start video mode
```

---

## 🔍 Search mode features

- Search or type a URL directly in the search bar at the center of the screen
- Choose your search engine from **Google / Bing / DuckDuckGo / Wikipedia** (dropdown above the search bar)
- Save frequently used sites as tiles (add with the ＋ button, remove with right-click)
- Multiple tabs and browsing history work exactly like a real Chromium browser
  - `Ctrl + T`: new tab　`Ctrl + H`: history　`Ctrl + Shift + T`: reopen a closed tab

---

## 🎬 Video mode features

- Shortcut tiles for YouTube / Twitch / Niconico / Vimeo are there from the start
- The screen transfer settings are tuned for smooth video playback
- Audio is delivered through a dedicated streaming path (a virtual speaker inside the Codespace → an audio stream)
- You can search for videos from the search bar too (it goes to YouTube search)

### An honest note about audio

Because audio is streamed over the network, it can't be **perfectly gapless or zero-latency**. Expect a delay of a few hundred milliseconds to about a second, and occasional dropouts depending on your connection. That said, it's tuned to be practically usable.

If video or audio is choppy:
- Upgrading your Codespace's machine spec can help (`Settings → Codespaces → Machine type`)
- Lowering the video quality setting on the video site itself often helps too

---

## 💾 About data storage (GitHub account integration)

Saved sites (bookmarks) are automatically stored in **a private repository just for you**, `<your-username>/suiramu-data`.

- This repository is created automatically the first time you run it (Private)
- New sites you add are saved there automatically within a few seconds
- Creating a new Codespace will automatically load the same data
- No email address or password is ever entered or stored (it simply reuses the GitHub authentication already present in your Codespace)

---

## 🌍 Supported languages

Use the dropdown in the top-right corner to switch the on-screen language:

🇯🇵 日本語 / 🇺🇸 English / 🇨🇳 中文 / 🇰🇷 한국어 / 🇪🇸 Español / 🇫🇷 Français

To translate an external site you're visiting, Chromium's built-in translate feature works as usual (right-click the page → "Translate").

### Typing in Japanese, Chinese, Korean, and more

By default, only alphanumeric input is available. If you want to type in a language that needs an input method (like Japanese or Chinese), run **the command for your language** once in the Codespace terminal. The input framework itself (fcitx5) is already installed — you're only adding the language-specific engine.

| Language | Command to run in the terminal |
|---|---|
| 🇯🇵 Japanese | `sudo apt-get install -y fcitx5-mozc` |
| 🇨🇳 Chinese (Simplified) | `sudo apt-get install -y fcitx5-pinyin` |
| 🇹🇼 Chinese (Traditional) | `sudo apt-get install -y fcitx5-chewing` |
| 🇰🇷 Korean | `sudo apt-get install -y fcitx5-hangul` |
| 🇻🇳 Vietnamese | `sudo apt-get install -y fcitx5-unikey` |
| 🇹🇭 Thai | `sudo apt-get install -y fcitx5-libthai` |

After installing, run `npm run search` (or `video`) again to start using it.

**Usage (same for all languages):**
- Click into an input field and type; conversion candidates will appear automatically
- Toggle the input method on/off with the Zenkaku/Hankaku key, or `Ctrl + Space`

For languages not listed above, a `fcitx5-` package is often available too. You can search for it in the terminal:

```bash
apt-cache search fcitx5
```

---

## ✉️ Contact / Feedback

Use "Contact / Feedback" in the side menu to send a message through a simple form. Submitting it opens a GitHub Issue creation screen (a GitHub account is required).

To post directly, go [here](https://github.com/godrenkon/suiramu-search/issues/new/choose).

---

## 🔒 About privacy

- The "Account" icon is just a simple display-name profile, stored only inside your Codespace's browser
- Saved-site data is stored in a private repository under your own GitHub account, and is never sent to any server run by the Suiramu project
- No email address or password is ever requested

---

## 🛠️ Technical details (for the curious)

| Technology | Role |
|---|---|
| GitHub Codespaces | The execution environment (your own disposable PC) |
| Xvfb | Virtual display |
| Chromium | The actual browser that runs |
| x11vnc + noVNC | Streams the screen to your web browser |
| PulseAudio + ffmpeg | Audio streaming in video mode |
| GitHub CLI (`gh`) | Persists bookmarks (using your own private repository) |

Search mode and video mode use different noVNC/x11vnc compression settings (balancing image quality against frame rate) to optimize for each use case.

---

## ⚠️ FAQ

**Q. Opening port 6080 shows a blank desktop instead of Chromium**
A. There are two common causes.

1. **The port was opened before running `npm run search` or `npm run video`** — Suiramu's screen only appears after you run the command. Run the command in the terminal first, then open the ports tab.
2. **The browser failed to start** — run this in the terminal to check for errors:
   ```bash
   cat /tmp/suiramu-chrome.log
   ```
   If it's empty or shows an error, try re-running setup:
   ```bash
   npm run setup
   ```

**Q. It says "GitHub authentication not found"**
A. This appears when the authentication needed for automatic bookmark saving (to your private repository) can't be found. Everything else still works fine — bookmarks are just saved temporarily inside the Codespace instead. To enable persistence, try this in the terminal:
   ```bash
   gh auth login
   ```
   Then run `npm run search` (or `video`) again.

**Q. I want to use search and video mode at the same time**
A. Currently, each Codespace can only run one mode at a time. If you want both, open a second Codespace in your browser and start the other mode there (keep GitHub's free-tier limits in mind).

**Q. Is there a limit on Codespace usage time?**
A. This depends on your GitHub account type. Check GitHub's settings page for details.

**Q. Can I use sites that require login (like a school portal)?**
A. Yes. Since a real Chromium browser is running, you can log in and use it normally.

---

## 📞 Support

- 🐛 Bug reports / feature requests: [Issues](https://github.com/godrenkon/suiramu-search/issues/new/choose)

---

*Made for students who just want to search and watch, without the fuss.*
