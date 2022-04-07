param($user, $password, $domain)

Start-Transcript  "C:\add-dc-log.txt"

# Format data disk
Write-Output "Format data disk"
$disk = Get-Disk | Where-Object { $_.PartitionStyle -eq "RAW" }
Initialize-Disk -Number $disk.DiskNumber -PartitionStyle GPT
New-Partition -DiskNumber $disk.DiskNumber -UseMaximumSize -DriveLetter F
Format-Volume -DriveLetter F -FileSystem NTFS -NewFileSystemLabel DATA

# Create credentials objects
Write-Output "Create credentials objects"
$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)
$cred = new-object -typename System.Management.Automation.PSCredential `
         -argumentlist "$user@$domain", $smPassword

# Set up DNS and Domain Controller
Write-Output "Install AD"
Install-WindowsFeature -Name "AD-Domain-Services" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature 

# Promote this machine to be a Domain Controller, attached to existing domain
Write-Output "Promote to DC"
Install-ADDSDomainController -DomainName $domain `
                             -NoGlobalCatalog:$false `
                             -CreateDnsDelegation:$false `
                             -Credential $cred `
                             -CriticalReplicationOnly:$false `
                             -DatabasePath "F:\Windows\NTDS" `
                             -InstallDns:$true `
                             -LogPath "F:\Windows\NTDS" `
                             -NoRebootOnCompletion:$true `
                             -SiteName "Default-First-Site-Name" `
                             -SysvolPath "F:\Windows\SYSVOL" `
                             -Force:$true `
                             -SafeModeAdministratorPassword $smPassword 

Write-Output "Done...restarting"
Stop-Transcript
Restart-Computer

