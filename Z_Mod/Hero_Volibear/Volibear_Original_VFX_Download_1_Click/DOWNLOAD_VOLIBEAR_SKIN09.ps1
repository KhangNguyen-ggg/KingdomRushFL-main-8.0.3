# Original Riot/CommunityDragon asset downloader (unmodified files).
# Target: https://raw.communitydragon.org/14.24/game/assets/characters/volibear/skins/skin09/particles/
# Runs on Windows PowerShell 5.1+ with no extra software. Saves all original files
# recursively; makes a ZIP only after the complete source manifest is downloaded.
# Does NOT modify any Kingdom Rush / League game files.

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$source = 'https://raw.communitydragon.org/14.24/game/assets/characters/volibear/skins/skin09/particles/'
$root = [Uri]$source
$expectedCount = 153  # Fixed CommunityDragon 14.24 index: 149 top-level assets + 2 OBJ files.
$raw = Join-Path $PSScriptRoot 'Volibear_Skin09_Original\particles'
$outZip = Join-Path $PSScriptRoot 'Volibear_Skin09_Original_CDragon_14.24.zip'
$tmpZip = Join-Path $PSScriptRoot 'Volibear_Skin09_Original_CDragon_14.24.temporary.zip'
$manifest = Join-Path $PSScriptRoot 'Volibear_Skin09_Original_SHA256.csv'
$script:seenDirs = @{}
$script:found = @{}

function Read-Directory([Uri]$pageUri) {
    if ($script:seenDirs.ContainsKey($pageUri.AbsoluteUri)) { return }
    $script:seenDirs[$pageUri.AbsoluteUri] = $true
    Write-Host ('Index: ' + $pageUri.AbsoluteUri) -ForegroundColor Cyan
    $response = Invoke-WebRequest -Uri $pageUri.AbsoluteUri -UseBasicParsing -TimeoutSec 60
    $html = [string]$response.Content
    $pattern = '(?i)<a\b[^>]*\bhref\s*=\s*["''](?<href>[^"'']+)["'']'
    $links = [regex]::Matches($html, $pattern)
    if ($links.Count -eq 0) { throw ('No directory links found at ' + $pageUri.AbsoluteUri) }
    foreach ($m in $links) {
        $href = [Net.WebUtility]::HtmlDecode($m.Groups['href'].Value)
        if ($href.StartsWith('?') -or $href.StartsWith('#')) { continue }
        try { $child = [Uri]::new($pageUri, $href) }
        catch { continue }
        if ($child.Scheme -ne 'https' -or $child.Host -ne $root.Host) { continue }
        if (-not $child.AbsolutePath.StartsWith($root.AbsolutePath, [StringComparison]::Ordinal)) { continue }
        if ($child.AbsoluteUri -eq $pageUri.AbsoluteUri) { continue }
        $relative = [Uri]::UnescapeDataString($child.AbsolutePath.Substring($root.AbsolutePath.Length))
        if ([string]::IsNullOrWhiteSpace($relative) -or $relative.Contains('..')) { continue }
        if ($child.AbsolutePath.EndsWith('/')) {
            Read-Directory $child
        } else {
            $script:found[$child.AbsoluteUri] = $relative.Replace('/', '\')
        }
    }
}

function Validate-DownloadedFile([string]$file, [string]$relative) {
    $item = Get-Item -LiteralPath $file
    if ($item.Length -lt 8) { throw ('Suspicious empty/truncated download: ' + $relative) }
    $fs = [IO.File]::OpenRead($file)
    try {
        $bytes = New-Object byte[] 16
        $n = $fs.Read($bytes, 0, 16)
    } finally { $fs.Dispose() }
    if ($relative.ToLowerInvariant().EndsWith('.png')) {
        $magic = @(137,80,78,71,13,10,26,10)
        for ($i=0; $i -lt 8; $i++) {
            if ($bytes[$i] -ne $magic[$i]) { throw ('File is not a valid PNG: ' + $relative) }
        }
    } else {
        $lead = [Text.Encoding]::ASCII.GetString($bytes, 0, $n).ToLowerInvariant()
        if ($lead.Contains('<!doctype') -or $lead.Contains('<html')) {
            throw ('Server returned HTML instead of asset: ' + $relative)
        }
    }
}

try {
    Write-Host '=== ORIGINAL VOLIBEAR SKIN09 VFX - COMMUNITYDRAGON 14.24 ===' -ForegroundColor Cyan
    Write-Host ('Source: ' + $source)
    Write-Host 'Reading source directory, including its subfolders...'
    Read-Directory $root

    $urls = @($script:found.Keys | Sort-Object)
    $count = $urls.Count
    Write-Host ('Found {0} original files in {1} directories.' -f $count, $script:seenDirs.Count)
    if ($count -ne $expectedCount) {
        throw ('Expected {0} files for this pinned version, but found {1}. Refusing an incomplete ZIP.' -f $expectedCount,$count)
    }
    New-Item -ItemType Directory -Path $raw -Force | Out-Null
    $success = 0
    foreach ($url in $urls) {
        $rel = $script:found[$url]
        $target = Join-Path $raw $rel
        $parent = Split-Path -Parent $target
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
        if (Test-Path -LiteralPath $target -PathType Leaf) {
            try {
                Validate-DownloadedFile $target $rel
                $success++
                Write-Host ('[{0}/{1}] Cached: {2}' -f $success,$count,$rel)
                continue
            } catch {
                Write-Warning ('Cached file invalid, re-downloading: ' + $rel)
                Remove-Item -LiteralPath $target -Force
            }
        }
        $ok = $false
        for ($attempt=1; $attempt -le 5; $attempt++) {
            $part = $target + '.part'
            try {
                if (Test-Path -LiteralPath $part) { Remove-Item -LiteralPath $part -Force }
                Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $part -TimeoutSec 90
                Validate-DownloadedFile $part $rel
                Move-Item -LiteralPath $part -Destination $target -Force
                $ok = $true
                break
            } catch {
                Write-Warning ('Attempt {0}/5 FAILED for {1}: {2}' -f $attempt,$rel,$_.Exception.Message)
                if (Test-Path -LiteralPath $part) { Remove-Item -LiteralPath $part -Force }
                Start-Sleep -Seconds ([Math]::Min(3 * $attempt,12))
            }
        }
        if (-not $ok) { throw ('Cannot download: ' + $url + '. Run this tool again to resume.') }
        $success++
        Write-Host ('[{0}/{1}] Downloaded: {2}' -f $success,$count,$rel) -ForegroundColor Green
    }

    $actualFiles = @(Get-ChildItem -LiteralPath $raw -File -Recurse | Where-Object { $_.Name -notlike '*.part' })
    if ($actualFiles.Count -ne $count) { throw ('Found {0} local files; expected {1}' -f $actualFiles.Count,$count) }

    # Create a separate checksum list. Preserve original source files inside ZIP.
    $hashRows = foreach($file in $actualFiles) {
        [pscustomobject]@{
            RelativePath = $file.FullName.Substring($raw.Length + 1).Replace('\','/')
            Bytes = $file.Length
            SHA256 = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
        }
    }
    $hashRows | Sort-Object RelativePath | Export-Csv -LiteralPath $manifest -NoTypeInformation -Encoding UTF8

    if (Test-Path -LiteralPath $tmpZip) { Remove-Item -LiteralPath $tmpZip -Force }
    Write-Host 'Compressing all 153 original assets (including two OBJ subfolders)...' -ForegroundColor Cyan
    Compress-Archive -LiteralPath $raw -DestinationPath $tmpZip -CompressionLevel Optimal -Force
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [IO.Compression.ZipFile]::OpenRead($tmpZip)
    try {
        $zipFiles = @($zip.Entries | Where-Object { $_.Name -ne '' })
        if ($zipFiles.Count -ne $count) { throw ('Archive contains {0} files instead of {1}' -f $zipFiles.Count,$count) }
    } finally { $zip.Dispose() }
    Move-Item -LiteralPath $tmpZip -Destination $outZip -Force
    Write-Host ''
    Write-Host 'SUCCESS: Entire original folder downloaded and packed!' -ForegroundColor Green
    Write-Host ('Files: ' + $count)
    Write-Host ('ZIP: ' + $outZip)
    Write-Host ('SHA256 manifest: ' + $manifest)
    Write-Host 'No source assets were renamed, recompressed individually, or modified.'
    exit 0
} catch {
    Write-Host ''
    Write-Host ('FAILED: ' + $_.Exception.Message) -ForegroundColor Red
    Write-Host 'Any completed downloads are kept. Double-click the CMD file again to resume.' -ForegroundColor Yellow
    exit 1
}
