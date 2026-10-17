@echo off
setlocal
set "KRFL_BLOCK_DIR=%~dp0"
set "KRFL_BLOCK_SELF=%~f0"
rem PowerShell reads the code below this marker without running the game.
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$text = [IO.File]::ReadAllText($env:KRFL_BLOCK_SELF); $marker = '# POWERSHELL_' + 'PAYLOAD'; & ([scriptblock]::Create($text.Substring($text.IndexOf($marker) + $marker.Length)))"
set "KRFL_BLOCK_EXIT=%errorlevel%"
echo.
pause
exit /b %KRFL_BLOCK_EXIT%
# POWERSHELL_PAYLOAD
$ErrorActionPreference = 'Stop'
try {
    if (-not (Get-ChildItem -LiteralPath $env:KRFL_BLOCK_DIR -File -Filter 'Kingdom Rush*.exe')) {
        $record = Join-Path (Split-Path -Parent $env:KRFL_BLOCK_SELF) 'GAME_DIRECTORY.txt'
        if (Test-Path -LiteralPath $record) { $env:KRFL_BLOCK_DIR = [IO.File]::ReadAllText($record).Trim() }
        else { $env:KRFL_BLOCK_DIR = (Read-Host 'Nhap thu muc game da cai patch').Trim().Trim('"') }
        $env:KRFL_BLOCK_DIR = (Resolve-Path -LiteralPath $env:KRFL_BLOCK_DIR).Path
        if (-not (Get-ChildItem -LiteralPath $env:KRFL_BLOCK_DIR -File -Filter 'Kingdom Rush*.exe')) { throw 'No Kingdom Rush EXE found.' }
    }
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host 'Administrator permission is required. Click Yes in the Windows prompt.'
        $dirLiteral = $env:KRFL_BLOCK_DIR.Replace("'", "''")
        $selfLiteral = $env:KRFL_BLOCK_SELF.Replace("'", "''")
        $bootstrap = "`$env:KRFL_BLOCK_DIR='$dirLiteral'; `$env:KRFL_BLOCK_SELF='$selfLiteral'; `$text=[IO.File]::ReadAllText(`$env:KRFL_BLOCK_SELF); `$marker='# POWERSHELL_'+'PAYLOAD'; & ([scriptblock]::Create(`$text.Substring(`$text.IndexOf(`$marker)+`$marker.Length)))"
        $encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($bootstrap))
        $process = Start-Process -FilePath "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" -Verb RunAs -WindowStyle Hidden -ArgumentList @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand', $encoded) -Wait -PassThru
        if ($process.ExitCode -ne 0) { throw 'The administrator task failed. See Block_Game_Internet.log.' }
        Write-Host 'Done. See Block_Game_Internet.log for the blocked programs.'
        exit 0
    }
    $logPath = Join-Path $env:KRFL_BLOCK_DIR 'Block_Game_Internet.log'
    $games = @(Get-ChildItem -LiteralPath $env:KRFL_BLOCK_DIR -File -Filter '*.exe' | Where-Object { $_.Name -like 'Kingdom Rush*.exe' })
    if ($games.Count -eq 0) { throw 'No Kingdom Rush EXE found. Put this BAT beside the game EXE, then run it again.' }
    $messages = @('Run: ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
    foreach ($game in $games) {
        $sha = [Security.Cryptography.SHA256]::Create()
        try { $pathHash = [BitConverter]::ToString($sha.ComputeHash([Text.Encoding]::UTF8.GetBytes($game.FullName.ToLowerInvariant()))).Replace('-', '').Substring(0, 20) } finally { $sha.Dispose() }
        $ruleName = 'KRFL-Block-Internet-' + $pathHash
        $existing = Get-NetFirewallRule -Name $ruleName -ErrorAction SilentlyContinue
        if ($existing) {
            $existing | Set-NetFirewallRule -Enabled True -Direction Outbound -Action Block -Profile Any
            $existing | Get-NetFirewallApplicationFilter | Set-NetFirewallApplicationFilter -Program $game.FullName
        } else {
            New-NetFirewallRule -Name $ruleName -DisplayName ('Block Internet - ' + $game.Name) -Direction Outbound -Program $game.FullName -Action Block -Profile Any -Enabled True | Out-Null
        }
        $rule = Get-NetFirewallRule -Name $ruleName
        $app = $rule | Get-NetFirewallApplicationFilter
        if ($rule.Enabled -ne 'True' -or $rule.Action -ne 'Block' -or $rule.Direction -ne 'Outbound' -or $app.Program -ne $game.FullName) { throw ('Rule verification failed: ' + $game.FullName) }
        $messages += 'BLOCKED: ' + $game.FullName
        $messages += 'Rule: ' + $ruleName
    }
    $disabled = @(Get-NetFirewallProfile | Where-Object { -not $_.Enabled })
    if ($disabled.Count) { $messages += 'WARNING: Firewall is disabled for these profiles: ' + (($disabled | ForEach-Object Name) -join ', ') + '. Enable Windows Firewall for blocking to take effect.' }
    $messages | Set-Content -LiteralPath $logPath -Encoding UTF8
    exit 0
} catch {
    $failure = 'ERROR: ' + $_.Exception.Message
    Write-Host $failure
    try { $failure | Set-Content -LiteralPath (Join-Path $env:KRFL_BLOCK_DIR 'Block_Game_Internet.log') -Encoding UTF8 } catch {}
    exit 1
}
