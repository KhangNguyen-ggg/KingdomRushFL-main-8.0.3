param([string]$GameDirectory,[string]$BackupDirectory)
$ErrorActionPreference='Stop'
function File-Hash([string]$Path) {
    $stream=[IO.File]::OpenRead($Path)
    $sha=[Security.Cryptography.SHA256]::Create()
    try { return [BitConverter]::ToString($sha.ComputeHash($stream)).Replace('-','') }
    finally { $stream.Dispose(); $sha.Dispose() }
}
function Checked-Path([string]$Base,[string]$Relative) {
    if ([IO.Path]::IsPathRooted($Relative) -or $Relative -match '(^|[\\/])\.\.([\\/]|$)') { throw 'Unsafe path' }
    $full=[IO.Path]::GetFullPath((Join-Path $Base $Relative))
    $prefix=[IO.Path]::GetFullPath($Base).TrimEnd('\','/')+[IO.Path]::DirectorySeparatorChar
    if (-not $full.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)) { throw 'Unsafe path' }
    return $full
}
try {
    if (-not $GameDirectory) { $GameDirectory=Read-Host 'Duong dan thu muc game' }
    if (-not $BackupDirectory) { $BackupDirectory=Read-Host 'Duong dan thu muc VietHoa-Backup' }
    $gameRoot=(Resolve-Path -LiteralPath $GameDirectory.Trim().Trim('"')).Path
    $backupRoot=(Resolve-Path -LiteralPath $BackupDirectory.Trim().Trim('"')).Path
    $manifest=Get-Content (Join-Path $PSScriptRoot 'manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json
    $items=Get-Content (Join-Path $backupRoot 'RESTORE-LIST.json') -Raw -Encoding UTF8 | ConvertFrom-Json
    foreach ($item in $items) {
        $entry=@($manifest.files | Where-Object path -eq $item.Relative)
        if ($entry.Count -ne 1) { throw 'Backup does not match patch manifest' }
        $target=Checked-Path $gameRoot $item.Relative
        if (Test-Path -LiteralPath $target -PathType Leaf) {
            if ((File-Hash $target) -ne $entry[0].patch_sha256) {
                throw "Tep da bi sua sau khi cai patch: $($item.Relative). Dung de tranh mat thay doi."
            }
        }
        if ($item.Existed) {
            $backup=Checked-Path $backupRoot $item.Relative
            $expected = if ($item.OriginalSHA256) { $item.OriginalSHA256 } else { $entry[0].original_sha256 }
            if ((File-Hash $backup) -ne $expected) { throw 'Backup hash mismatch' }
        }
    }
    foreach ($item in $items) {
        $target=Checked-Path $gameRoot $item.Relative
        if ($item.Existed) {
            Copy-Item -LiteralPath (Checked-Path $backupRoot $item.Relative) -Destination $target -Force
        } elseif (Test-Path -LiteralPath $target -PathType Leaf) {
            Remove-Item -LiteralPath $target -Force
        }
    }
    Write-Host 'Da phuc hoi cac tep truoc khi cai patch.'
} catch { Write-Host ('LOI: '+$_.Exception.Message) -ForegroundColor Red; exit 1 }
