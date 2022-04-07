param($user, $password, $domain)

Start-Transcript  "C:\deploy-ad-log.txt"

# Format data disk
Write-Output "Format data disk"
$disk = Get-Disk | Where-Object { $_.PartitionStyle -eq "RAW" }
Initialize-Disk -Number $disk.DiskNumber -PartitionStyle GPT
New-Partition -DiskNumber $disk.DiskNumber -UseMaximumSize -DriveLetter F
Format-Volume -DriveLetter F -FileSystem NTFS -NewFileSystemLabel DATA

# Create credentials objects
Write-Output "Create credentials objects"
$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)

# Set up DNS and Domain Controller
Write-Output "Install AD"
Install-WindowsFeature -Name "AD-Domain-Services" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature 

Write-Output "Installing DNS"
Install-WindowsFeature -Name DNS -IncludeManagementTools

# Create new domain
Write-Output "Creating new ADDSForest for domain $domain on this Domain Controller"
Install-ADDSForest -DomainName $domain `
    -DomainMode Win2012 `
    -ForestMode Win2012 `
    -SafeModeAdministratorPassword $smPassword `
    -DatabasePath "F:\Windows\NTDS" `
    -SysvolPath "F:\Windows\SYSVOL" `
    -LogPath "F:\Windows\NTDS" `
    -NoRebootOnCompletion `
    -Force 

Write-Output "Done...restarting"
Stop-Transcript
Restart-Computer