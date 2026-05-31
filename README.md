# Firebase CLI 원클릭 키트

> Windows에서 Firebase CLI를 클릭 한 번으로 설치·실행·제거하는 배치 파일 키트

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](./LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-0078d4.svg)](https://www.microsoft.com/windows)
[![Node](https://img.shields.io/badge/Node.js-18%2B-green.svg)](https://nodejs.org/)

**[English README →](./README_EN.md)**

---

## 소개

Firebase CLI를 처음 접하는 분도 명령어 없이 `.bat` 파일 더블클릭만으로 설치부터 배포까지 모든 작업을 할 수 있습니다.

---

## 포함된 파일

| 파일 | 역할 |
|------|------|
| `INSTALL.bat` | Firebase CLI 설치 — Node.js·npm·인터넷을 자동으로 확인하고 설치 |
| `RUN.bat` | 25개 메뉴 대화형 실행기 — 로그인·배포·에뮬레이터 등 |
| `UNINSTALL.bat` | Firebase CLI 안전 제거 — 코드 프로젝트와 Node.js는 건드리지 않음 |

---

## 요구사항

| 항목 | 버전 |
|------|------|
| Windows | 10 또는 11 (64-bit) |
| Node.js | 18 이상 (권장: 20 LTS) |
| npm | Node.js 설치 시 자동 포함 |
| 인터넷 | 설치·업데이트·배포 시 필요 |

> Node.js가 없으면 INSTALL.bat이 자동으로 안내해 줍니다.

---

## 빠른 시작 — 왕초보 가이드

### 1단계: Node.js 설치 (이미 있으면 건너뛰세요)

1. 웹 브라우저에서 **[https://nodejs.org/](https://nodejs.org/)** 를 여세요.
2. 초록색 **LTS** 버튼을 눌러 파일을 받으세요.
3. 받은 파일을 열고 **Next → Next → Install** 을 클릭하세요.
4. 설치 후 PC를 재시작하세요.

### 2단계: 이 키트 받기

- 이 페이지 오른쪽 위 **Code → Download ZIP** 을 누르거나
- 터미널에서 `git clone https://github.com/sodam-ai/Firebase-CLI_One-Click_Kit.git`

### 3단계: Firebase CLI 설치

1. 다운받은 폴더 안에서 **`INSTALL.bat`** 을 더블클릭하세요.
2. **"관리자 권한 요청"** 창이 뜨면 **예** 를 클릭하세요.
3. 화면에 `ALL DONE! INSTALL WAS A SUCCESS!` 가 나오면 완료입니다.

### 4단계: Firebase 로그인 및 사용

1. **`RUN.bat`** 을 더블클릭하세요.
2. 메뉴에서 **`1) Login to Firebase`** 를 선택하세요.
3. 브라우저에서 Google 계정으로 로그인하세요.
4. 메뉴로 돌아와 원하는 번호를 선택하세요.

---

## RUN.bat 메뉴 전체 안내

```
=== 계정 ===
1)  Firebase 로그인
2)  Firebase 로그아웃
3)  현재 로그인 계정 확인
4)  재인증 (로그아웃 후 재로그인)

=== 버전 ===
5)  Firebase CLI 최신 버전으로 업데이트
6)  Firebase CLI 버전 확인
7)  Node.js / npm 버전 확인
8)  최신 버전 있는지 확인

=== 프로젝트 ===
9)  새 Firebase 프로젝트 초기화 (firebase init)
10) 내 Firebase 프로젝트 목록 보기
11) 사용할 프로젝트 선택
12) 현재 선택된 프로젝트 확인

=== 실행 및 배포 ===
13) 로컬에서 앱 실행 (firebase serve)
14) 테스트 에뮬레이터 시작
15) 전체 배포 (Firebase 서버로 전송)
16) Hosting만 배포
17) Functions만 배포
18) Hosting 사이트 목록
19) 최근 Functions 로그

=== 기타 ===
20) 전체 Firebase 명령어 도움말
21) Firebase 웹 콘솔 열기
22) Firebase 공식 문서 열기
23) 현재 폴더 탐색기에서 열기
24) Firebase CLI 설치 경로 확인
25) 직접 Firebase 명령어 입력 (고급)

0)  종료
```

---

## 제거 방법

1. **`UNINSTALL.bat`** 을 더블클릭하세요.
2. **"관리자 권한 요청"** 창에서 **예** 를 클릭하세요.
3. 안내를 읽고 `YES` 를 입력하세요.
4. 설정 백업 여부를 `Y` 또는 `N` 으로 선택하세요.
5. `UNINSTALL DONE! ALL CLEAN!` 이 나오면 완료입니다.

**제거되는 항목:** Firebase CLI 프로그램, 로그인 정보, 설정 파일, 캐시  
**제거되지 않는 항목:** 내 코드 프로젝트, Node.js, npm

---

## 오류 대처

| 오류 메시지 | 원인 | 해결 방법 |
|-------------|------|-----------|
| `Node.js is not on this PC` | Node.js 미설치 | [nodejs.org](https://nodejs.org/) 에서 LTS 설치 후 재시도 |
| `npm is not on this PC` | npm 미설치 | Node.js를 다시 설치하면 npm도 함께 설치됨 |
| `Can not reach the internet` | 인터넷 연결 문제 | Wi-Fi·케이블 확인 후 재시도 |
| `Install did not work` | 설치 실패 | 관리자 권한으로 실행했는지 확인, 바이러스 백신 확인 |
| `ALMOST! firebase not found` | PATH 미반영 | 새 명령 프롬프트를 열고 `firebase --version` 입력 |

> 상세 오류 내용은 같은 폴더의 `firebase_install.log` 파일에서 확인할 수 있습니다.

---

## 보안 주의사항

- 이 키트는 `firebase-tools` 를 **npm 전역(글로벌)** 으로 설치합니다.
- 설치·제거 시 **관리자 권한** 이 요청됩니다 — Windows 보안 정책에 따른 정상 동작입니다.
- `firebase_install.log`, `firebase_uninstall.log` 에는 설치 기록만 저장되며 **개인정보나 인증 정보는 포함되지 않습니다.**
- Firebase 로그인 토큰과 인증 정보는 이 키트가 아닌 **Firebase CLI 자체** 가 관리합니다.
- 이 저장소에는 API 키, 토큰, 비밀번호 등 민감한 정보가 포함되어 있지 않습니다.

---

## 폴더 구조

```
Firebase-CLI_One-Click_Kit/
├── INSTALL.bat          # Firebase CLI 설치
├── RUN.bat              # 대화형 실행 메뉴
├── UNINSTALL.bat        # 안전 제거
├── README.md            # 한국어 문서 (이 파일)
├── README_EN.md         # 영어 문서
├── LICENSE              # Apache License 2.0
└── .gitignore
```

---

## 라이선스

Apache License 2.0 — 자세한 내용은 [LICENSE](./LICENSE) 파일을 참고하세요.

© 2026 SoDam AI Studio
