# Start komorebi + whkd + bar en open de vaste apps op ws1 en ws2.
# Wordt aangeroepen via een snelkoppeling in shell:startup.

function Wait-Komorebi {
    for ($i = 0; $i -lt 60; $i++) {
        komorebic state *> $null
        if ($LASTEXITCODE -eq 0) { return }
        Start-Sleep -Milliseconds 500
    }
}

# Wacht tot een proces een zichtbaar venster heeft, en geef komorebi daarna even tijd
function Wait-Window($name, $timeoutSec = 30) {
    $deadline = (Get-Date).AddSeconds($timeoutSec)
    while ((Get-Date) -lt $deadline) {
        $p = Get-Process -Name $name -ErrorAction SilentlyContinue |
             Where-Object { $_.MainWindowHandle -ne 0 }
        if ($p) { Start-Sleep -Seconds 2; return }
        Start-Sleep -Milliseconds 500
    }
}

if (-not (Get-Process komorebi -ErrorAction SilentlyContinue)) {
    komorebic start --whkd
}
Wait-Komorebi

# Focus follows mouse (masir, komorebi-aware)
if (-not (Get-Process masir -ErrorAction SilentlyContinue)) {
    Start-Process "C:\Program Files\masir\bin\masir.exe" -WindowStyle Hidden
}

# ws1: Outlook + Teams (die gaan via initial_workspace_rules vanzelf naar 1), Alacritty
komorebic focus-named-workspace 1
Start-Process "shell:AppsFolder\Microsoft.OutlookForWindows_8wekyb3d8bbwe!Microsoft.OutlookforWindows"
Start-Process "shell:AppsFolder\MSTeams_8wekyb3d8bbwe!MSTeams"
Start-Process alacritty
Wait-Window alacritty

# ws2: Firefox. Bitwarden kan komorebi niet beheren (beschermd proces);
# zet in Bitwarden "Start to tray" + "Close to tray" aan, dan start hij in de tray.
komorebic focus-named-workspace 2
Start-Process "$env:LOCALAPPDATA\Programs\Bitwarden\Bitwarden.exe"
Start-Process firefox
Wait-Window firefox 60

komorebic focus-named-workspace 1
