# Firebase One-Click Kit (Firebase CLI One-Click Kit)

> Install, use, and remove Google's **Firebase CLI (firebase-tools)** with **a few clicks** — built for **absolute beginners**.
> You don't need to know a single command. A Korean-first guide tells you **"the one number to press now."**
>
> 🇬🇧 This is the English document. **한국어 → [README.md](./README.md)**

---

## 📖 Table of Contents

1. [What is this?](#1-what-is-this)
2. [⚡ Quick Start (3 steps)](#2--quick-start-3-steps)
3. [Prerequisites / Required Programs](#3-prerequisites--required-programs)
4. [How to Download](#4-how-to-download)
5. [How to Install](#5-how-to-install)
6. [How to Run & Use](#6-how-to-run--use)
7. [How It Works](#7-how-it-works)
8. [📂 File & Document Locations](#8--file--document-locations)
9. [⌨️ Commands (menu number ↔ real command)](#9-️-commands-menu-number--real-command)
10. [🛟 Troubleshooting](#10--troubleshooting)
11. [🔐 Safety & Permissions](#11--safety--permissions)
12. [❓ FAQ](#12--faq)
13. [📜 License · Copyright · Commercial Use](#13--license--copyright--commercial-use)

---

## 1. What is this?

- **Firebase** = Google's **toolkit for building apps** — host a website on the internet, store data, add sign-in, and more.
- **firebase-tools** = the **program (CLI) that controls Firebase from your PC**.
- **This kit** = a Korean-first helper that lets **beginners install, use, and remove** firebase-tools **with clicks only**.

> One-line summary: **Double-click `시작하기.bat` (Start Here) → press the number the screen tells you.** That's it.

---

## 2. ⚡ Quick Start (3 steps)

| Step | What | How |
|---|---|---|
| **1** | Open the kit | Double-click **`시작하기.bat`** (Start Here) in the folder |
| **2** | Install | Choose **[1] Install** (arrow keys or number `1`) |
| **3** | Log in & use | **[2] Use** → menu **1) Login** → then any task |

> The top of the screen always points to your next step with **"지금 이것! ←" (do this now)**. Just follow it.

---

## 3. Prerequisites / Required Programs

| Item | Required? | Notes |
|---|---|---|
| **Windows 10 / 11** | ✅ Required | This kit is for Windows only. |
| **Internet connection** | ✅ Required | Needed for install, login, and deploy. |
| **Node.js** (includes npm) | ✅ Required | The **engine** firebase-tools runs on. **You don't need it beforehand** — the installer **offers to install it automatically.** |
| **Google account** | Required to use | Needed for login / projects / deploy. (Not needed just to install.) |

> When you open `시작하기.bat`, the top **[Your PC status]** panel automatically shows whether Node.js, Firebase, and login are ready.

---

## 4. How to Download

1. On the GitHub kit page, click the green **`< > Code`** button → **`Download ZIP`** (or a zip from Releases).
2. **Right-click the zip → Extract All**.
3. When you see `시작하기.bat` inside the extracted folder, you're ready.

> ⚠️ **If a downloaded file is blocked (important):** Windows may lock files downloaded from the internet for safety.
> - **Easiest:** **before** extracting, right-click the zip → **Properties → check 'Unblock' at the bottom → OK**, then extract.
> - If a blue **"Windows protected your PC"** window appears → **More info → Run anyway**.
> - Once `시작하기.bat` runs once, **the rest of the files in the folder are unblocked automatically.**

---

## 5. How to Install

1. Double-click **`시작하기.bat`**.
2. Choose **[1] Install** (move with ↑↓ arrows and press **Enter**, or press number **`1`**).
3. A black install window runs in English. **Do not close it; wait 1–3 minutes.**
4. When you see `ALL DONE! INSTALL WAS A SUCCESS!`, install **succeeded**.

**If it says Node.js (the engine) is missing?**
→ It asks "Install Node.js automatically? (Y/N)". Type **`Y`** and it installs for you.
→ Only then a Windows permission window may appear once (for Node) → **[Yes]**. It's safe.
→ When auto-install finishes, close the window and run **`시작하기.bat` once more**.

> 💡 Install needs **no administrator rights**, because firebase-tools installs into **your own user folder**. (That's why no Yes/No admin popup appears.)

---

## 6. How to Run & Use

After install, go to **`시작하기.bat` → [2] Use**, which opens the **Use menu (RUN)** with 25 actions.

### First-time order (workflow)

```
[1] Login  ->  [9] Create project  ->  [11] Pick project  ->  [15] Deploy (publish online)
 (Google)        (firebase init)         (project to use)        (make it public)
```

1. **Login (menu 1):** a browser opens → **sign in with your Google account** → close it on success. (Once only; it's remembered.)
2. **Create project (menu 9):** when English questions appear, use **arrow keys (↑↓) + spacebar** to pick, then **Enter**.
3. **Pick project (menu 11):** enter the ID you saw in your project list (menu 10).
4. **Deploy (menu 15):** publishes your app **to the internet**. For safety you must type **`YES` (uppercase)** to proceed.

> "Deploy" goes public, so the kit always asks once more. Closing the window does nothing harmful.

---

## 7. How It Works

```
시작하기.bat ──> lib\start.ps1 (Korean guide: status detection + menu)
                     │
                     ├─ [1] ──> INSTALL.bat    (install firebase-tools)
                     ├─ [2] ──> RUN.bat        (login/projects/deploy, 25 menus)
                     ├─ [3] ──> UNINSTALL.bat  (safe removal)
                     ├─ [4] ──> 사용설명서.md  (open beginner guide)
                     └─ [5] ──> open Firebase website
```

- **`시작하기.bat`** is the **single door** that opens the Korean guide (`lib\start.ps1`). The other `.bat` files are **run automatically** by the guide, so you don't click them directly.
- The guide **auto-detects** your PC state (Node, Firebase, login) and **points to your next step**.
- Real work runs in the black (English) window, but the guide explains it in Korean first.

---

## 8. 📂 File & Document Locations

### Files inside the kit

| File | Role |
|---|---|
| **`시작하기.bat`** | Korean guide. **Start here.** |
| `INSTALL.bat` | Install firebase-tools (run automatically) |
| `RUN.bat` | 25-menu: login, projects, deploy (run automatically) |
| `UNINSTALL.bat` | Safe removal (run automatically; keeps your code) |
| `lib\start.ps1` | The body of the Korean guide |
| `README.md` / `README.en.md` | Documentation (KO/EN) — this file |
| `사용설명서.md` / `GUIDE.en.md` | Beginner guide (KO/EN) |
| `LICENSE` / `NOTICE` | License · copyright notices |

### Locations the kit creates/uses (reference)

| What | Location |
|---|---|
| firebase-tools install folder | `C:\Users\<you>\AppData\Roaming\npm` (your folder; no admin) |
| Login data | `C:\Users\<you>\.config\configstore\firebase-tools.json` |
| Install log | `firebase_install.log` in the kit folder |
| Uninstall log | `firebase_uninstall.log` in the kit folder |

---

## 9. ⌨️ Commands (menu number ↔ real command)

You **don't need to memorize commands.** Press a number and the kit runs it for you. The table below is just so you know what runs underneath.

| Menu | What it does | Real command |
|---|---|---|
| 1 | Login | `firebase login` |
| 2 | Logout | `firebase logout` |
| 3 | Who is logged in | `firebase login:list` |
| 4 | Re-login | `firebase login --reauth` |
| 5 | Update the tool | `npm install -g firebase-tools` |
| 6 | Show version | `firebase --version` |
| 7 | Node/npm versions | `node -v` / `npm -v` |
| 8 | Check for new version | `npm view firebase-tools version` |
| 9 | Create a project | `firebase init` |
| 10 | List my projects | `firebase projects:list` |
| 11 | Pick a project | `firebase use <ID>` |
| 12 | Current project | `firebase use` |
| 13 | Run app on my PC | `firebase serve` |
| 14 | Test emulators | `firebase emulators:start` |
| 15 | Deploy everything | `firebase deploy` |
| 16 | Deploy hosting only | `firebase deploy --only hosting` |
| 17 | Deploy functions only | `firebase deploy --only functions` |
| 18 | List hosting sites | `firebase hosting:sites:list` |
| 19 | Functions logs | `firebase functions:log` |
| 20 | All commands help | `firebase --help` |
| 24 | Where is firebase | `where firebase` |
| 25 | Run your own command | `firebase <your input>` |

> Advanced users can use **menu 25** to type whatever goes after `firebase` and run any command (e.g., `apps:list`).

---

## 10. 🛟 Troubleshooting

| Screen / situation | What to do |
|---|---|
| File won't open / **"Windows protected your PC" / blocked** | Windows locked the downloaded file. **Right-click → Properties → check 'Unblock' → OK** (see section 4) |
| **`firebase ... not found`** (installed but not found) | Close **all** windows and run `시작하기.bat` in a **fresh window** (Windows needs a new window to see the new program) |
| **`Can not reach the internet`** | Check Wi-Fi/internet and retry. On work/school networks, ask IT |
| **`Install did not work`** | Open **`firebase_install.log`** in the folder and read the last line (antivirus / corporate network blocking is common) |
| Scary English black window | **It's normal.** Don't close it; follow the Korean guide's explanation |
| Typed a wrong menu number | It just returns to the menu. No worries |

---

## 11. 🔐 Safety & Permissions

- **No administrator rights are needed for install or uninstall.** firebase-tools is installed/removed only in **your user folder** (`AppData\Roaming\npm`), so no Yes/No admin popup appears.
  - Exception: only when **Node.js is missing and auto-installed** may a Windows permission window appear once (to install the engine) → **[Yes]**, it's safe.
- **Deploy** publishes your app **to the internet**, so the kit always requires you to type **`YES`** once more.
- **Uninstall** keeps **your code files, Node.js, and your data on Google's servers** intact. It only removes firebase-tools and its settings/cache.

---

## 12. ❓ FAQ

**Q. Do I need to memorize commands?**
A. No. Just press numbers. (Advanced users can type their own in Use menu 25.)

**Q. Does it cost money?**
A. This kit is **free** and unrelated to fees. However, **Firebase itself** may incur Google charges (Blaze plan) with heavy usage — check the Google console.

**Q. What if I press something wrong?**
A. Risky actions (deploy, remove) always **ask once more.** You can just close the window.

**Q. Do I always need the internet?**
A. For install, login, and deploy, yes. Some things (like checking an installed version) work offline.

---

## 13. 📜 License · Copyright · Commercial Use

> This section is written to a **strict standard**. Please review before use.

### This kit
- **License: Apache License 2.0** — see [`LICENSE`](./LICENSE) in this folder for the full text.
- **Copyright: © 2026 SoDam AI Studio.**
- Apache-2.0 **permits commercial use, modification, and redistribution.** It is provided **AS-IS, without warranty**; you are responsible for your use (LICENSE sections 7–8).

### External program this kit helps you install/use
- **firebase-tools (Firebase CLI)** — **License: MIT License**, **Copyright: © Google LLC.**
  Source: <https://github.com/firebase/firebase-tools> (this kit only **installs it from the public npm registry**; it does not include or redistribute the code.)
- **Node.js** — a trademark of the OpenJS Foundation. Source: <https://nodejs.org/>

### Trademark · non-affiliation notice
- This kit is an **independent helper** and is **NOT affiliated with, endorsed by, or sponsored by Google, Firebase, or the OpenJS Foundation.**
- **"Firebase" and "Google"** are trademarks of Google LLC.

### Note on commercial use
- **This kit:** commercial use is allowed under Apache-2.0.
- **Firebase service itself:** Google's **terms and pricing** apply separately based on usage. For commercial use, review [Firebase pricing](https://firebase.google.com/pricing) and [Google's terms](https://firebase.google.com/terms) directly. **This kit takes no responsibility for that.**

---

## 14. 🧰 Development · Operations · Security Notes

- **Environment variables:** **None** to set. The kit only uses Windows defaults (`%APPDATA%`, `%USERPROFILE%`). (No API key needed up front — login is done via the browser.)
- **Build:** **No build step.** Everything runs directly as `.bat` / `.ps1` scripts.
- **Test / verify:** Run `시작하기.bat`; if the **[Your PC status]** panel correctly shows Node/Firebase/login state, it works. After install, verify with `firebase --version`.
- **Security:** No admin rights required, no external server, no secrets/keys included (local only). The install log (`firebase_install.log`) is not committed (handled by .gitignore).
- **Operations:** Update the tool via Use menu **5**. On problems, check the last line of `firebase_install.log`.

---

<sub>This kit is an unofficial helper for installing/using Google's firebase-tools (MIT). Not affiliated with Google or Firebase.</sub>
