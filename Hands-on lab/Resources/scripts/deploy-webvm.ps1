param($zipurl, $datasource="keep-default", $password="keep-default")

Start-Transcript "C:\deploy-webvm-log.txt"

# Install IIS
Install-WindowsFeature -Name "web-server" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature

# Download and Unpack the Website
If (Test-Path "D:") {
	$downloadedFile = "D:\ContosoInsuranceIIS.zip"
} else {
	$downloadedFile = "$env:temp\ContosoInsuranceIIS.ps1"
}
$inetpubFolder = "C:\inetpub\wwwroot"
Invoke-WebRequest $zipurl -OutFile $downloadedFile
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($downloadedFile, $inetpubFolder)

# Replace the database name in the Web.Config
if ($datasource -ne "keep-default"){
    (Get-Content "C:\inetpub\wwwroot\Web.config").replace('bcdraog.contoso.com', $datasource) | Set-Content "C:\inetpub\wwwroot\Web.config"
}

# Replace the password in the Web.Config
if ($password -ne "keep-default"){
    (Get-Content "C:\inetpub\wwwroot\Web.config").replace('demo@pass123', $password) | Set-Content "C:\inetpub\wwwroot\Web.config"
}


# Disable IE Enhanced Security Configuration
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"

New-Item -Path $adminKey -Force
New-Item -Path $UserKey -Force
New-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
New-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0

$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\Software\Microsoft\Internet Explorer\Security"
New-ItemProperty -Path $HKLM -Name "DisableSecuritySettingsCheck" -Value 1 -PropertyType DWORD

Stop-Transcript