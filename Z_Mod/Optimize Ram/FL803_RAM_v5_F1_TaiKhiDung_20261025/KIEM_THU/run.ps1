param([ValidateSet('baseline803','image803','game805','canvas805','candidate803','trim803','lite803','lite805','deferred803','bosses803','baselineBoss803')][string]$Variant='baseline803')
$ErrorActionPreference='Stop'
$taskRoot='D:\CodexTemp\KRFL_RAM_803_805_20261025'
$target=Join-Path $taskRoot $Variant
$helper='D:\CodexTemp\KRFL_Boss9_Crash_20261022\runtime\love-probe.exe'
$process=Start-Process -FilePath $helper -ArgumentList ('"'+$target+'"') -WorkingDirectory $target -WindowStyle Hidden -RedirectStandardOutput (Join-Path $target 'stdout.txt') -RedirectStandardError (Join-Path $target 'stderr.txt') -PassThru
$watch=[Diagnostics.Stopwatch]::StartNew()
[long]$peakPrivate=0
[long]$peakWorking=0
$reason=$null
while(-not $process.WaitForExit(500)){
 $process.Refresh()
 $peakPrivate=[math]::Max($peakPrivate,$process.PrivateMemorySize64)
 $peakWorking=[math]::Max($peakWorking,$process.WorkingSet64)
 if($process.PrivateMemorySize64 -gt 5700MB -or $watch.Elapsed.TotalSeconds -gt 370){
  $reason='Probe memory/time budget reached'
  if($process.ProcessName -ne 'love-probe'){throw 'Unexpected probe process'}
  Stop-Process -Id $process.Id
  $process.WaitForExit()
  break
 }
}
$process.Refresh()
$report=[ordered]@{variant=$Variant;exit_code=$process.ExitCode;seconds=[math]::Round($watch.Elapsed.TotalSeconds,2);peak_private_MiB=[math]::Round($peakPrivate/1MB,1);peak_working_MiB=[math]::Round($peakWorking/1MB,1);stop_reason=$reason}
$report|ConvertTo-Json|Set-Content -LiteralPath (Join-Path $target 'process.json')
$report|ConvertTo-Json
if(Test-Path -LiteralPath (Join-Path $target 'result.txt')){Get-Content -LiteralPath (Join-Path $target 'result.txt')}
