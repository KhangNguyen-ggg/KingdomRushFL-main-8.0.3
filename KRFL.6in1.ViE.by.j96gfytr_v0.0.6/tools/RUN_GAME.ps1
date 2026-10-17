param([ValidateSet("light","normal","diagnostic")][string]$Mode="normal")
$ErrorActionPreference="Stop"
$baseDirectory=Split-Path -Parent $PSScriptRoot
$gameDirectory=$baseDirectory
$exeName="Kingdom Rush FL_Alliance-FL8.0.3.exe"
if (-not (Test-Path -LiteralPath (Join-Path $gameDirectory $exeName))) {
    $record=Join-Path $baseDirectory "GAME_DIRECTORY.txt"
    if (Test-Path -LiteralPath $record) { $gameDirectory=[IO.File]::ReadAllText($record).Trim() }
    else { $gameDirectory=(Read-Host "Nhap thu muc game da cai patch").Trim().Trim('"') }
}
$gameDirectory=(Resolve-Path -LiteralPath $gameDirectory).Path
$exe=Join-Path $gameDirectory $exeName
if (-not (Test-Path -LiteralPath $exe -PathType Leaf)) { throw "Khong tim thay EXE game" }
$env:KRFL_LOW_SPEC=if ($Mode -eq "light") { "1" } else { "" }
$env:KRFL_VI_DIAGNOSTIC=if ($Mode -eq "diagnostic") { "1" } else { "" }
Set-Location -LiteralPath $gameDirectory
& $exe
