param($user, $password, $dbsource, $scripturl)

Start-Transcript "C:\deploy-sql-wrapper-log.txt"

# Get the second script
If (Test-Path "D:") {
	$script = "d:\script.ps1"
} else {
	$script = "$env:temp\script.ps1"
}
Write-Output "Download $scripturl to $script"
[Net.ServicePointManager]::SecurityProtocol = "Tls12"
Invoke-WebRequest -URI $scripturl -OutFile $script

Write-Output "Create credential"
$securePwd =  ConvertTo-SecureString "$password" -AsPlainText -Force
If ($user -notmatch "[@\\]") {
	$username = "$env:COMPUTERNAME\$user"
} else {
	$username = $user
}
if ($user -match "(?<user>[^@]+)(@(?<dnsDomain>[^@\s]+))") {
	$dnsDomain = $matches.dnsDomain
	$ArgumentList = @($password, $dbsource, $dnsDomain)
} else {
	$ArgumentList = @($password, $dbsource)
}
$credential = New-Object System.Management.Automation.PSCredential($username, $securePwd)

Write-Output "Enable remoting and invoke"
Enable-PSRemoting -force
Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any
Invoke-Command -FilePath $script -Credential $credential -ComputerName $env:COMPUTERNAME -ArgumentList $ArgumentList
Disable-PSRemoting -Force

Stop-Transcript