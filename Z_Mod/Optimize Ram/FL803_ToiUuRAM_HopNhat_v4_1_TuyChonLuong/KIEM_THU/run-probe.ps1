param([ValidateSet('native','full')][string]$Probe='full',[int]$LimitMiB=3000)
$ErrorActionPreference='Stop'
$taskRoot='D:\CodexTemp\KRFL_RAM_v4_20261023'
$helper='D:\CodexTemp\KRFL_Boss9_Crash_20261022\runtime\love-probe.exe'
$target=Join-Path $taskRoot $Probe
$resultName=if($Probe -eq 'full'){'full_result.txt'}else{'result.txt'}
$resultPath=Join-Path $taskRoot $resultName
$stamp=Get-Date -Format 'HHmmss'
if(Test-Path -LiteralPath $resultPath){Move-Item -LiteralPath $resultPath -Destination ($resultPath+'.'+$stamp+'.previous')}
$process=Start-Process -FilePath $helper -ArgumentList ('"'+$target+'"') -WorkingDirectory 'D:\Kingdom Rush Frontiers Tower Defense v5.4.07\KingdomRushFL-main 8.0.3' -WindowStyle Hidden -RedirectStandardOutput (Join-Path $taskRoot ($Probe+'_stdout.txt')) -RedirectStandardError (Join-Path $taskRoot ($Probe+'_stderr.txt')) -PassThru
[long]$peakPrivate=0
[long]$peakWorkingSet=0
$reason=$null
$watch=[Diagnostics.Stopwatch]::StartNew()
while(-not $process.WaitForExit(300)){
 $process.Refresh()
 $freeCommit=(Get-CimInstance Win32_OperatingSystem).FreeVirtualMemory
 if($freeCommit -lt 1048576 -or $process.PrivateMemorySize64 -gt $peakPrivate){$peakPrivate=$process.PrivateMemorySize64}
 if($process.WorkingSet64 -gt $peakWorkingSet){$peakWorkingSet=$process.WorkingSet64}
 if($process.PrivateMemorySize64 -gt ($LimitMiB*1MB) -or $watch.Elapsed.TotalSeconds -gt 390){
  $reason='Probe stopped at safety budget or timeout'
  if($process.ProcessName -ne 'love-probe'){throw 'Unexpected probe process'}
  Stop-Process -Id $process.Id
  $process.WaitForExit()
  break
 }
}
$process.Refresh()
$report=[ordered]@{probe=$Probe;exit_code=$process.ExitCode;seconds=[math]::Round($watch.Elapsed.TotalSeconds,2);peak_private_MiB=[math]::Round($peakPrivate/1MB,1);peak_working_MiB=[math]::Round($peakWorkingSet/1MB,1);stop_reason=$reason}
$report | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $taskRoot ($Probe+'_process.json'))
$report | ConvertTo-Json
if(Test-Path -LiteralPath $resultPath){Get-Content -LiteralPath $resultPath}
