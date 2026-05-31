# Firebase CLI One-Click Kit

> A batch file kit for Windows — install, run, and remove Firebase CLI with a single double-click.

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](./LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-0078d4.svg)](https://www.microsoft.com/windows)
[![Node](https://img.shields.io/badge/Node.js-18%2B-green.svg)](https://nodejs.org/)

**[한국어 README →](./README.md)**

---

## Overview

Designed for beginners — no command-line knowledge needed. Just double-click a `.bat` file and follow the on-screen prompts to go from zero to Firebase deployment.

---

## Files Included

| File | Purpose |
|------|---------|
| `INSTALL.bat` | Install Firebase CLI — auto-checks Node.js, npm, and internet |
| `RUN.bat` | Interactive 25-option launcher — login, deploy, emulators, and more |
| `UNINSTALL.bat` | Safely remove Firebase CLI — preserves your code and Node.js |

---

## Requirements

| Item | Version |
|------|---------|
| Windows | 10 or 11 (64-bit) |
| Node.js | 18 or higher (recommended: 20 LTS) |
| npm | Included with Node.js |
| Internet | Required for install, update, and deploy |

> If Node.js is missing, `INSTALL.bat` will detect it and guide you through the fix.

---

## Quick Start — Beginner's Guide

### Step 1: Install Node.js (skip if already installed)

1. Open your browser and go to **[https://nodejs.org/](https://nodejs.org/)**
2. Click the green **LTS** button to download the installer.
3. Open the downloaded file and click **Next → Next → Install**.
4. Restart your PC after installation.

### Step 2: Get this kit

- Click **Code → Download ZIP** at the top of this page, or
- Run `git clone https://github.com/sodam-ai/Firebase-CLI_One-Click_Kit.git` in a terminal.

### Step 3: Install Firebase CLI

1. Open the downloaded folder and **double-click `INSTALL.bat`**.
2. Click **Yes** when Windows asks for administrator permission.
3. When you see `ALL DONE! INSTALL WAS A SUCCESS!`, you're ready.

### Step 4: Log in and start using Firebase

1. **Double-click `RUN.bat`**.
2. Choose **`1) Login to Firebase`** from the menu.
3. Sign in with your Google account in the browser that opens.
4. Return to the menu window and pick any option.

---

## RUN.bat — Full Menu Reference

```
=== ACCOUNT ===
1)  Login to Firebase
2)  Logout from Firebase
3)  Show who is logged in
4)  Reauthenticate (logout then login)

=== VERSION ===
5)  Update Firebase Tools to newest
6)  Show Firebase Tools version
7)  Show Node.js and npm versions
8)  Check if a newer version is available

=== PROJECT ===
9)  Make a new Firebase project here (firebase init)
10) Show my Firebase projects
11) Pick which project to use
12) Show project I am using now

=== RUN AND DEPLOY ===
13) Run app on my PC (firebase serve)
14) Start test emulators
15) Deploy everything to Firebase
16) Deploy only Hosting
17) Deploy only Functions
18) Show hosting sites
19) Show recent Functions logs

=== MORE ===
20) Show all Firebase commands (help)
21) Open Firebase web console
22) Open Firebase documentation
23) Open this folder in File Explorer
24) Show where Firebase CLI is installed
25) Run a custom Firebase command (advanced)

0)  Exit
```

---

## Uninstall

1. **Double-click `UNINSTALL.bat`**.
2. Click **Yes** when prompted for administrator permission.
3. Read the summary and type `YES` to confirm.
4. Choose `Y` or `N` to optionally back up your Firebase settings.
5. When you see `UNINSTALL DONE! ALL CLEAN!`, removal is complete.

**What gets removed:** Firebase CLI program, login data, settings files, cache  
**What is NOT touched:** Your code projects, Node.js, npm

---

## Troubleshooting

| Error Message | Cause | Fix |
|---------------|-------|-----|
| `Node.js is not on this PC` | Node.js not installed | Install LTS from [nodejs.org](https://nodejs.org/) and retry |
| `npm is not on this PC` | npm missing | Reinstall Node.js — npm is included |
| `Can not reach the internet` | No internet | Check your Wi-Fi or cable connection |
| `Install did not work` | Install failed | Confirm you clicked Yes on the admin prompt; check antivirus |
| `ALMOST! firebase not found` | PATH not refreshed | Open a new Command Prompt and run `firebase --version` |

> Full error details are saved in `firebase_install.log` in the same folder.

---

## Security Notes

- This kit installs `firebase-tools` **globally** via npm.
- **Administrator permission** is required for install and uninstall — this is normal Windows behavior.
- `firebase_install.log` and `firebase_uninstall.log` store installation records only — **no personal data or credentials are included**.
- Firebase login tokens and auth data are managed by **Firebase CLI itself**, not this kit.
- This repository contains no API keys, tokens, passwords, or other sensitive information.

---

## Folder Structure

```
Firebase-CLI_One-Click_Kit/
├── INSTALL.bat          # Firebase CLI installer
├── RUN.bat              # Interactive run menu
├── UNINSTALL.bat        # Safe uninstaller
├── README.md            # Korean documentation
├── README_EN.md         # English documentation (this file)
├── LICENSE              # Apache License 2.0
└── .gitignore
```

---

## License

Apache License 2.0 — see the [LICENSE](./LICENSE) file for details.

© 2026 SoDam AI Studio
