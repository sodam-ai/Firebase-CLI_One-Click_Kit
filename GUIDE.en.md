# Beginner Guide — Firebase One-Click Kit

> Written **exactly as you see it on screen**, so even first-time computer users can follow along.
> Hard words are explained **in parentheses**.
> 🇬🇧 English. **한국어 → [사용설명서.md](./사용설명서.md)**

---

## 📖 Order of this guide

- 0. Before you start (just one thing)
- 0-1. When a file won't open (unblock the download)
- 1. Install
- 2. Login
- 3. Prepare your project
- 4. Publish to the internet (Deploy)
- 5. Uninstall
- 6. When an error happens
- 7. FAQ

---

## 0. Before you start (just one thing)

Double-click **`시작하기.bat`** (Start Here) in the folder.
In blue text it shows **your PC status** and **"what to do now"** in one line. Just follow that.

> A black (or blue) window may appear — that's normal.

**How to choose a menu:** move with the **up/down arrows (↑↓) and press Enter**, or press a **number key**.
The green **"지금 이것! ←" (do this now)** is your next step. The red **(주의 / caution)** marks the item to be careful with (Uninstall).

---

## 0-1. When a file won't open or "protected" warning appears (unblock the download)

Windows may **lock** files downloaded from the internet for safety. Just unblock them.

- **Way 1 (easiest):** **before** extracting, right-click the received zip → **Properties → check 'Unblock' at the bottom → OK**, then extract.
- **Way 2:** right-click `시작하기.bat` → **Properties → check 'Unblock' → OK**, then double-click.
- If a blue **"Windows protected your PC"** window appears → **More info → Run anyway**.

> Once `시작하기.bat` runs, the rest of the files in the folder are **unblocked automatically.** (So usually you only deal with this once.)

---

## 1. Install (just once)

1. `시작하기.bat` → choose **[1] Install** (pick with arrows + Enter, or press number `1`).
2. (The **admin permission window usually does not appear** now. It may appear once only if Node.js is auto-installed → then press **[Yes]**.)
3. A black window runs in English. **Don't close it; wait** (1–3 minutes).
4. When you see `ALL DONE! INSTALL WAS A SUCCESS!`, it succeeded.

**If it says Node.js (the engine) is missing?**
→ It asks "Install automatically? (Y/N)". Press **`Y`** and it installs for you.
→ When auto-install finishes, close the window and run **`시작하기.bat` once more**.

---

## 2. First use — Login (connect your Google account)

1. `시작하기.bat` → **[2] Use**
2. In the menu, choose **1) Login to Firebase**
3. A web browser opens by itself → **sign in with your Google account**
4. When you see "success", close the browser and return to the black window.

> You only log in once. It's remembered afterward.

---

## 3. Prepare your project (needed before deploy)

Order matters: **Login → Create project → Deploy**

1. Menu **9) Make a new Firebase project here**
2. When English questions appear, pick with **arrow keys (↑↓) and spacebar**, then **Enter**
3. Use menu **10** to see your project list, and **11** to pick the project to use

---

## 4. Publish to the internet (Deploy) — caution!

> Deploy = making your app **public on the internet for everyone to see**.

1. Menu **15) Deploy everything**
2. For safety, you must type **`YES` (uppercase)** to proceed.
3. If there's no project config (`firebase.json`), the kit **blocks it** and tells you "do menu 9 first".

---

## 5. Uninstall (remove)

1. `시작하기.bat` → **[3] Uninstall** (red **(caution)** mark)
2. Type **`YES`** → it asks whether to back up settings (Y/N).
3. It is cleanly removed.

**Rest assured:** even after removal,
- your **code files** stay,
- **Node.js** stays,
- your **data on Google's servers** stays.

---

## 6. When an error happens (don't panic)

| If you see this | Do this |
|---|---|
| File won't open / **"Windows protected your PC" / blocked** | See **0-1. unblock the download** above (right-click → Properties → Unblock) |
| `firebase ... not found` (installed but not found) | Close all windows and run `시작하기.bat` in a **fresh window** |
| `Can not reach the internet` | Check Wi-Fi/internet and retry |
| `Install did not work` | Open **`firebase_install.log`** in the folder and read the last line (antivirus / corporate network blocking is common) |
| Typed a wrong menu number | It just returns to the menu. No worries |

---

## 7. FAQ

**Q. Do I need to memorize commands?**
A. No. Just press numbers. (Advanced users can type their own command in RUN menu 25.)

**Q. Does it cost money?**
A. This kit is free. But heavy Firebase usage may incur Google charges — check the Google console. (This kit is unrelated to fees.)

**Q. What if I press something wrong?**
A. Risky actions (deploy, remove) always **ask once more.** You can just close the window.

---

> For more reference (file locations, command table, license), see **[README.en.md](./README.en.md)**.
