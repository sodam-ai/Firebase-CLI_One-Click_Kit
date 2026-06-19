# =====================================================================
#  Firebase 원클릭 키트 - 시작하기 (한국어 안내판)
#  비개발자용: 지금 무엇을 눌러야 하는지 한 줄로 알려줍니다.
#  (영어 INSTALL/RUN/UNINSTALL.bat 엔진을 한국어로 안내만 합니다.)
# =====================================================================

$ErrorActionPreference = 'SilentlyContinue'
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}

$LibDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root   = Split-Path -Parent $LibDir
Set-Location $Root

# 다운로드 차단(Mark of the Web) 자동 해제 - 받은 파일이 윈도우에 막히지 않게
try { Get-ChildItem -LiteralPath $Root -Recurse -File -ErrorAction SilentlyContinue | Unblock-File -ErrorAction SilentlyContinue } catch {}

function Has-Command([string]$name) {
    $c = Get-Command $name -ErrorAction SilentlyContinue
    return [bool]$c
}

function Get-FbVersion {
    if (-not (Has-Command 'firebase')) { return $null }
    $v = (& firebase --version 2>$null | Select-Object -First 1)
    return $v
}

# 로그인 여부는 설정 파일로 빠르게(오프라인) 판단합니다. (정확한 확인은 RUN 메뉴 3번)
function Is-LoggedIn {
    $cfg = Join-Path $env:USERPROFILE '.config\configstore\firebase-tools.json'
    if (Test-Path $cfg) {
        $txt = Get-Content -LiteralPath $cfg -Raw -ErrorAction SilentlyContinue
        if ($txt -match '"user"' -or $txt -match '"tokens"') { return $true }
    }
    return $false
}

function Pause-Key {
    Write-Host ''
    Write-Host '  계속하려면 아무 키나 누르세요...' -ForegroundColor DarkGray
    [void]$Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}

# 화살표(위/아래)로 고르고 Enter, 또는 번호키로 선택하는 메뉴.
# 화살표 입력을 못 받는 환경이면 자동으로 '번호 입력' 방식으로 폴백합니다.
function Read-Menu {
    param(
        [bool]$HasNode, [bool]$HasFb, [string]$FbVer, [bool]$Logged,
        [array]$Items, [string]$RecKey = '1'
    )
    # 추천 항목에 커서를 처음부터 올려둠 (그냥 Enter만 눌러도 추천 작업 실행)
    $idx = 0
    for ($i = 0; $i -lt $Items.Count; $i++) { if ($Items[$i].Key -eq $RecKey) { $idx = $i; break } }

    while ($true) {
        Clear-Host
        Write-Host ''
        Write-Host '  ============================================' -ForegroundColor Cyan
        Write-Host '     Firebase 원클릭 키트 - 시작하기' -ForegroundColor Cyan
        Write-Host '  ============================================' -ForegroundColor Cyan
        Write-Host ''
        Write-Host '  [지금 내 컴퓨터 상태]'
        if ($HasNode) { Write-Host '   - Node.js (필수 부품)   : 있음  [OK]' -ForegroundColor Green }
        else          { Write-Host '   - Node.js (필수 부품)   : 없음  [설치 필요]' -ForegroundColor Yellow }
        if ($HasFb)   { Write-Host ("   - Firebase 도구         : 있음 (v{0})  [OK]" -f $FbVer) -ForegroundColor Green }
        else          { Write-Host '   - Firebase 도구         : 없음  [설치 필요]' -ForegroundColor Yellow }
        if ($HasFb) {
            if ($Logged) { Write-Host '   - 구글 로그인           : 되어 있음  [OK]' -ForegroundColor Green }
            else         { Write-Host '   - 구글 로그인           : 안 됨  [로그인 필요]' -ForegroundColor Yellow }
        }
        Write-Host ''
        Write-Host '  ============================================' -ForegroundColor Cyan
        Write-Host '   위/아래 화살표로 고르고 Enter, 또는 번호키를 누르세요' -ForegroundColor DarkCyan
        Write-Host '  ============================================' -ForegroundColor Cyan
        Write-Host ''
        for ($i = 0; $i -lt $Items.Count; $i++) {
            $it = $Items[$i]
            $sel = ($i -eq $idx)
            $bullet = if ($sel) { ' > ' } else { '   ' }
            $text = ("{0}[{1}] {2}{3}" -f $bullet, $it.Key, $it.Text, $it.Mark)
            if ($sel) { Write-Host $text -ForegroundColor Black -BackgroundColor $it.Color }
            else      { Write-Host $text -ForegroundColor $it.Color }
        }
        Write-Host ''

        try {
            $k = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        } catch {
            # 화살표 입력 불가 환경 -> 번호 입력 방식으로 폴백 (기존 동작 보존)
            $typed = Read-Host '   번호를 입력하고 Enter'
            if ($null -eq $typed) { $typed = '' }
            $m = $Items | Where-Object { $_.Key -eq $typed.Trim() }
            if ($m) { return $m.Key } else { continue }
        }

        $vk = $k.VirtualKeyCode
        if     ($vk -eq 38) { $idx--; if ($idx -lt 0) { $idx = $Items.Count - 1 } }   # 위 화살표
        elseif ($vk -eq 40) { $idx++; if ($idx -ge $Items.Count) { $idx = 0 } }       # 아래 화살표
        elseif ($vk -eq 13) { return $Items[$idx].Key }                               # Enter
        else {
            $ch = ("{0}" -f $k.Character).Trim()
            if ($ch -ne '') {
                $m = $Items | Where-Object { $_.Key -eq $ch }
                if ($m) { return $m.Key }
            }
        }
    }
}

$running = $true
while ($running) {
    $hasNode = Has-Command 'node'
    $hasFb   = Has-Command 'firebase'
    $fbVer   = Get-FbVersion
    $logged  = $false
    if ($hasFb) { $logged = Is-LoggedIn }

    # 추천 작업(상태에 따라 자동) + 색상으로 안전한 선택 안내
    if (-not $hasFb) { $recKey = '1' } else { $recKey = '2' }
    $cInstall = if (-not $hasFb) { 'Green' } else { 'Gray' }
    $cUse     = if ($hasFb)      { 'Green' } else { 'Gray' }

    $items = @(
        @{ Key='1'; Text='설치하기      (Firebase 도구를 컴퓨터에 깔기)';   Color=$cInstall;  Mark=$(if ($recKey -eq '1') { '   <- 지금 이것!' } else { '' }) },
        @{ Key='2'; Text='사용하기      (로그인 / 프로젝트 / 배포 메뉴)';   Color=$cUse;      Mark=$(if ($recKey -eq '2') { '   <- 지금 이것!' } else { '' }) },
        @{ Key='3'; Text='제거하기      (깨끗이 지우기, 내 코드는 안 지움)'; Color='Red';      Mark='   (주의)' },
        @{ Key='4'; Text='사용설명서    (왕초보 가이드 열기)';             Color='White';    Mark='' },
        @{ Key='5'; Text='Firebase 홈페이지 열기';                         Color='White';    Mark='' },
        @{ Key='0'; Text='끝내기';                                         Color='DarkGray'; Mark='' }
    )

    $choice = Read-Menu -HasNode $hasNode -HasFb $hasFb -FbVer "$fbVer" -Logged $logged -Items $items -RecKey $recKey
    if ($null -eq $choice) { $choice = '' }

    switch ($choice.Trim()) {
        '1' {
            Write-Host ''
            Write-Host '  설치 창을 엽니다. 검은 창이 영어로 떠도 놀라지 마세요 - 그대로 진행됩니다.' -ForegroundColor Gray
            Write-Host '  (이제 관리자 허용 창은 거의 안 뜹니다. 혹시 떠도 [예]를 누르면 됩니다.)' -ForegroundColor Gray
            if (-not $hasNode) {
                Write-Host '  (Node.js가 없으면 자동 설치를 권할 수 있어요. 그때만 뜨는 허용 창은 [예] 눌러도 안전합니다.)' -ForegroundColor Gray
            }
            Start-Process -FilePath (Join-Path $Root 'INSTALL.bat')
            Write-Host ''
            Write-Host '  설치가 끝나면 이 창으로 돌아와 아무 키나 누르세요. 상태를 다시 확인합니다.' -ForegroundColor Gray
            Pause-Key
        }
        '2' {
            if (-not $hasFb) {
                Write-Host ''
                Write-Host '  아직 설치가 안 되어 있어요. 먼저 [1] 설치하기 부터 해주세요.' -ForegroundColor Yellow
                Pause-Key
            } else {
                Start-Process -FilePath (Join-Path $Root 'RUN.bat')
                Write-Host ''
                Write-Host '  사용 메뉴 창을 열었습니다. 그 창에서 번호를 고르세요.' -ForegroundColor Gray
                Pause-Key
            }
        }
        '3' {
            Write-Host ''
            Write-Host '  제거 창을 엽니다. 정말 지울지 한 번 더 물어봅니다(YES 입력).' -ForegroundColor Gray
            Start-Process -FilePath (Join-Path $Root 'UNINSTALL.bat')
            Pause-Key
        }
        '4' {
            $guide = Join-Path $Root '사용설명서.md'
            if (Test-Path $guide) { Start-Process $guide }
            else { Start-Process (Join-Path $Root 'README.md') }
            Pause-Key
        }
        '5' {
            Start-Process 'https://console.firebase.google.com/'
            Pause-Key
        }
        '0' { $running = $false }
        default {
            Write-Host ''
            Write-Host '  그 번호는 메뉴에 없어요. 0~5 중에서 골라주세요.' -ForegroundColor Yellow
            Start-Sleep -Seconds 2
        }
    }
}

Clear-Host
Write-Host ''
Write-Host '  안녕히 가세요! 좋은 하루 되세요.' -ForegroundColor Cyan
Write-Host ''
Start-Sleep -Seconds 1
