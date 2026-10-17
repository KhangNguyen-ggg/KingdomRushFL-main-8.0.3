param([string]$GameDirectory, [switch]$CheckOnly)
$ErrorActionPreference = 'Stop'

function File-Hash([string]$Path) {
    $stream = [IO.File]::OpenRead($Path)
    $sha = [Security.Cryptography.SHA256]::Create()
    try { return [BitConverter]::ToString($sha.ComputeHash($stream)).Replace('-', '') }
    finally { $stream.Dispose(); $sha.Dispose() }
}

function Checked-Path([string]$Base, [string]$Relative) {
    if ([IO.Path]::IsPathRooted($Relative) -or $Relative -match '(^|[\\/])\.\.([\\/]|$)') {
        throw "Unsafe patch path: $Relative"
    }
    $full = [IO.Path]::GetFullPath((Join-Path $Base $Relative))
    $prefix = [IO.Path]::GetFullPath($Base).TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar
    if (-not $full.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Patch path escapes game folder: $Relative"
    }
    $probe = $full
    while ($probe -and $probe.Length -ge [IO.Path]::GetFullPath($Base).TrimEnd('\','/').Length) {
        if (Test-Path -LiteralPath $probe) {
            $node = Get-Item -LiteralPath $probe -Force
            if ($node.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw "Khong ghi qua link/junction: $Relative" }
        }
        $parent = Split-Path $probe -Parent
        if ($parent -eq $probe) { break }; $probe = $parent
    }
    return $full
}

try {
    if (-not $GameDirectory) {
        $GameDirectory = Read-Host 'Nhap duong dan thu muc game FL8.0.3 (khong phai thu muc patch)'
    }
    $GameDirectory = $GameDirectory.Trim().Trim('"')
    $gameRoot = (Resolve-Path -LiteralPath $GameDirectory).Path
    $manifestPath = Join-Path $PSScriptRoot 'manifest.json'
    $payloadRoot = Join-Path $PSScriptRoot 'COPY_INTO_GAME'
    $manifest = Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
    if (-not (Test-Path -LiteralPath (Join-Path $gameRoot 'Kingdom Rush FL_Alliance-FL8.0.3.exe') -PathType Leaf)) {
        throw 'Khong tim thay EXE FL8.0.3. Khong chep patch vao ban game khac.'
    }
    $warnings = @()
    foreach ($entry in $manifest.prerequisites) {
        $target = Checked-Path $gameRoot $entry.path
        $exists = Test-Path -LiteralPath $target -PathType Leaf
        $same = $exists -and (File-Hash $target) -eq $entry.sha256
        # Keep the runtime identity check; translations and older patch data may differ.
        if ($entry.path -eq 'Kingdom Rush FL_Alliance-FL8.0.3.exe' -and -not $same) {
            throw 'EXE khong khop runtime FL8.0.3 duoc ho tro. Chua thay doi tep nao.'
        }
        if (-not $same) { $warnings += "Du lieu tham chieu da khac / thieu (khong ghi de): $($entry.path)" }
    }
    foreach ($required in @('main.lua','main_globals.lua','version.lua','all/entity_db.lua','kr3/game_templates-3.lua')) {
        if (-not (Test-Path -LiteralPath (Checked-Path $gameRoot $required) -PathType Leaf)) {
            throw "Thu muc game thieu tep cau truc: $required. Chua thay doi tep nao."
        }
    }
    $seenPaths = @{}
    $work = @()
    foreach ($entry in $manifest.files) {
        if ($seenPaths.ContainsKey($entry.path)) { throw "Manifest trung duong dan: $($entry.path)" }
        $seenPaths[$entry.path] = $true
        $source = Checked-Path $payloadRoot $entry.path
        $target = Checked-Path $gameRoot $entry.path
        if ((File-Hash $source) -ne $entry.patch_sha256) {
            throw "Tep patch hong hoac da bi sua: $($entry.path)"
        }
        if (Test-Path -LiteralPath $target -PathType Container) { throw "Duong dan tep dang la thu muc: $($entry.path)" }
        $exists = Test-Path -LiteralPath $target -PathType Leaf
        $hash = if ($exists) { File-Hash $target } else { $null }
        if ($hash -eq $entry.patch_sha256) { continue }
        if ($exists -and $hash -ne $entry.original_sha256 -and @($entry.previous_patch_sha256) -notcontains $hash) {
            $warnings += "Se backup va cap nhat tep da chinh: $($entry.path)"
        }
        $work += [pscustomobject]@{ Relative=$entry.path; Source=$source; Target=$target; Existed=$exists; OriginalSHA256=$hash }
    }
    foreach ($warning in $warnings) { Write-Host $warning -ForegroundColor Yellow }
    if ($CheckOnly) { Write-Host "KIEM TRA OK: $($work.Count) tep can cap nhat. Chua ghi file nao."; exit 0 }
    if ($work.Count -eq 0) {
        Write-Host 'Patch da duoc cai va tat ca tep deu khop.'
        exit 0
    }
    # All hashes are checked before the first write. Backups are always kept.
    $backupRoot = Join-Path $gameRoot ('VietHoa-Backup-' + (Get-Date -Format 'yyyyMMdd-HHmmss-fff'))
    New-Item -ItemType Directory -Path $backupRoot | Out-Null
    foreach ($item in $work) {
        if ($item.Existed) {
            $backup = Checked-Path $backupRoot $item.Relative
            New-Item -ItemType Directory -Path (Split-Path $backup) -Force | Out-Null
            Copy-Item -LiteralPath $item.Target -Destination $backup
            if ((File-Hash $backup) -ne $item.OriginalSHA256) { throw "Backup khong khop: $($item.Relative). Chua ghi de tep game." }
        }
    }
    $work | Select-Object Relative,Existed,OriginalSHA256 | ConvertTo-Json -Depth 3 | Set-Content -LiteralPath (Join-Path $backupRoot 'RESTORE-LIST.json') -Encoding UTF8
    $written = @()
    try {
        foreach ($item in $work) {
            New-Item -ItemType Directory -Path (Split-Path $item.Target) -Force | Out-Null
            $written += $item
            Copy-Item -LiteralPath $item.Source -Destination $item.Target -Force
        }
        foreach ($entry in $manifest.files) {
            $target = Checked-Path $gameRoot $entry.path
            if ((File-Hash $target) -ne $entry.patch_sha256) {
                throw "Kiem tra sau khi cai that bai: $($entry.path)"
            }
        }
    } catch {
        foreach ($item in $written) {
            if ($item.Existed) {
                Copy-Item -LiteralPath (Checked-Path $backupRoot $item.Relative) -Destination $item.Target -Force
            } elseif (Test-Path -LiteralPath $item.Target -PathType Leaf) {
                Remove-Item -LiteralPath $item.Target -Force
            }
        }
        throw
    }
    try { [IO.File]::WriteAllText((Join-Path $PSScriptRoot 'GAME_DIRECTORY.txt'), $gameRoot) } catch { Write-Host 'Da cai thanh cong; khong luu duoc duong dan launcher. Chon lai thu muc game khi chay.' }
    Write-Host 'Da cai patch Viet hoa. Ban sao luu:' $backupRoot
    Write-Host 'Patch khong thay EXE/DLL, khong sua save, khong can quyen Administrator.'
} catch {
    Write-Host ('LOI: ' + $_.Exception.Message) -ForegroundColor Red
    exit 1
}
