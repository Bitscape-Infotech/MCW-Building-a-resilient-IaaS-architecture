param([int]$waitInSeconds)

Start-Transcript  "C:\deploy-wait-log.txt"

# Wait temporarily before proceeding
Write-Output "Holding for $waitInSeconds seconds..."
Start-Sleep -Seconds $waitInSeconds
Write-Output "Done."
Stop-Transcript
