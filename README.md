█      ███   ███   ███  █     █   █  ███   ████ █████ █████ ████     
█     █   █ █     █   █ █     █   █ █   █ █       █   █     █   █    
█     █   █ █     █████ █     █████ █   █  ███    █   ████  ████     
█     █   █ █     █   █ █     █   █ █   █     █   █   █     █  █     
█████  ███   ███  █   █ █████ █   █  ███  ████    █   █████ █   █    
# LocalHoster

**LocalHoster** turns your PC into a web host. It serves any website folder
on your machine (`http://localhost:8080`) and — if you want — gives you a
temporary public link that anyone can open in their browser.

No installation, no configuration, no account required. Just the files in
this folder.

---

## Features

- **One click to run** — double-click a `.bat` file and the site is live
  and opens in your browser automatically.
- **Works with Python or Node.js** — it uses whatever you already have
  installed (falling back to the bundled `server.js`).
- **Public link in seconds** — share your local site via a temporary
  Cloudflare tunnel (`https://xxx.trycloudflare.com`).
- **Portable** — the Cloudflare tunnel client (`cloudflared.exe`) is bundled,
  so there is nothing extra to download.
- **Remembers your website folder** — set the path once, reuse it forever.

---

## What's in this folder

| File | Purpose |
| --- | --- |
| `Запуск.bat` | **Main launcher.** Starts the server and opens the site in your browser. |
| `Изменить-путь.bat` | Choose a different website folder. |
| `Туннель.bat` | Create a **public** link for others via Cloudflare Tunnel. |
| `путь.txt` | Stores the path to your website folder (written automatically). |
| `Справка.txt` | Built-in instructions (in Russian, same as this README). |
| `server.js` | Lightweight Node.js static server — used as fallback if Python is missing. |
| `cloudflared.exe` | Cloudflare's Tunnel client (bundled so you don't have to install it). |

> Note: file names inside the project are in Russian (`Запуск` = "Launch",
> `Туннель` = "Tunnel"). Everything is explained here in English.

---

## Requirements

- **Windows** (the launchers are `.bat` files).
- **Python 3** (`python` available in PATH) **or** Node.js. Most PCs already
  have at least one of them. The launcher picks Python first, then Node.js.
- Nothing is needed for the public link — `cloudflared.exe` is bundled.

---

## Quick start (3 steps)

### 1. Run your site locally

Double-click **`Запуск.bat`**.

- The **first time**, it will ask you for the path to your website folder.
  You can simply **drag and drop the folder** onto the black window and press
  `Enter`. The path is saved in `путь.txt`.
- A server starts on a free port (`http://localhost:8080` — or `8081`, `8082`,
  ... if 8080 is busy) and your browser opens automatically.

**To stop:** close the black command-line window.

### 2. Switch to another folder

Double-click **`Изменить-путь.bat`**, enter a new path and press `Enter`.
The next launch of `Запуск.bat` will use the new folder.

### 3. Share your site publicly

> This is how you get a link like `https://xxx.trycloudflare.com` to send to
> friends.

1. First start the site with `Запуск.bat` (leave that window open).
2. Then double-click **`Туннель.bat`**.
3. After a few seconds a link appears — send it to anyone. They open it and
   play/see exactly what you see locally.

**Important:** the public link is **temporary**. It works only while the
Tunnel window is open. Close it → the link dies.

---

## How it works

```
Your PC                    Cloudflare            Visitors
┌─────────────────┐   ┌──────────────┐    ┌─────────────────┐
│  Запуск.bat     │   │ cloudflared  │    │  anyone with    │
│  starts a local ├──▶│  (Туннель)   ├───▶│  the link       │
│  HTTP server    │   │  creates     │    │  opens your     │
│  localhost:8080 │   │  public URL  │    │  site from home │
└─────────────────┘   └──────────────┘    └─────────────────┘
```

- `Запуск.bat` tries Python's built-in http server first
  (`python -m http.server`), then Node.js (via `server.js`), and warns you if
  both are missing.
- `Туннель.bat` runs `cloudflared tunnel --url http://localhost:8080`, which
  creates the public link.
- The local server serves static files (`html/css/js/images/audio/...` values
  are mapped in `server.js`).

---

## FAQ

**The black window says "index.html не найдено".**
Your website folder must contain an `index.html` (HTML page) in it. Use
`Изменить-путь.bat` to point to a folder that has one.

**Port 8080 is busy?**
No problem — `Запуск.bat` automatically tries 8080 → 8081 → 8082 → ... → 8085
and picks the first free one. It then shows you the exact address.

**The tunnel shows an error?**
Make sure `Запуск.bat` is running **first** (the Tunnel connects to
`http://localhost:8080`), and that an Internet connection is available.

**Can I use my own domain?** Yes — with Cloudflare's paid tunnel features.
This project only sets up the quick temporary link.

**Why are the filenames in Russian?**
The project was created by a Russian-speaking user; the `.bat` labels are
user-friendly names in Russian. The internal logic is fully portable and the
README explains every one of them.

---

## License

Feel free to use, modify and share this tool for any project. No warranty —
use at your own risk.
