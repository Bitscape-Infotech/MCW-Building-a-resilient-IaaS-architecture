<# 
Microsoft Cloud Workshop: BCDR
.File Name
 - ASRRunBookSQL.ps1

.What calls this script?
 - This is an Azure Automation Runbook used for Failing over and Failing Back SQL Always On Region to Region.
 
 - Azure Site Recovery is required for this to function properly as it relies on the context,
   of the failover type passed.

.What does this script do?  
 - When there is a Failover from Primary to Secondary the RecoveryPlanContext.FailoverDirection property 
   is set to: "PrimaryToSecondary", the script will force a manual failover allowing dataloss of the 
   SQL AOG from VM-EUS-PROD-SQL (Primary Replica/Auto) to VM-PROD-SQL-3(Secondary Replica/Manual) and then set the 
   VM-EUS-PROD-SQL and VMEUS-PROD-SQL2 to resume data movement (Data movement is Paused by SQL during manual failovers).
 
 - When there is a Failback from Secondary to Primary the RecoveryPlanContext.FailoverDirection property 
   is set to: "SecondaryToPrimary" and the script will then set VM-EUS-PROD-SQL to the Primary Replica.  VM-PROD-SQL-3
   will remain a Syncronous partern and must be manually configured back to Asynchronous / Manual once the
   BCDR team agrees this is a safe course of action.
 
#>
workflow ASRSQLFailover
{
    param ( 
        [parameter(Mandatory=$false)] 
        [Object]$RecoveryPlanContext 
    ) 

    Write-Output "RecoveryPlanContext:"
    Write-Output $($RecoveryPlanContext | ConvertTo-Json -Depth 5)

    $scriptBaseUri = "https://cloudworkshop.blob.core.windows.net/building-resilient-iaas-architecture/lab-resources/june-2020-update/scripts"
    $ASRFailoverScriptPath = "$scriptBaseUri/ASRFailOver.ps1"
	$ASRFailoverScriptPathVM-EUS-PROD-SQL = "$scriptBaseUri/ASRFailOverVM-EUS-PROD-SQL.ps1"
	$ASRFailoverScriptPathVMEUS-PROD-SQL2 = "$scriptBaseUri/ASRFailOverVMEUS-PROD-SQL2.ps1"
    $ASRFailBackScriptPath = "$scriptBaseUri/ASRFailBack.ps1"
    
    Write-Output "Script URLs:"
    Write-Output $ASRFailoverScriptPath
    Write-Output $ASRFailoverScriptPathVM-EUS-PROD-SQL
    Write-Output $ASRFailoverScriptPathVMEUS-PROD-SQL2
    Write-Output $ASRFailBackScriptPath
    
    $tempPath = "$env:TEMP\script.ps1"

    Try 
    {
        #Log in to Azure
        "Logging in to Azure..."
        $Conn = Get-AutomationConnection -Name AzureRunAsConnection 
        Add-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

        "Selecting Azure subscription..."
        Select-AzSubscription -SubscriptionId $Conn.SubscriptionID -TenantId $Conn.tenantid 
    }
    Catch
    {
        Write-Error -Message "Login to Azure subscription failed. Error: $_" -ErrorAction Stop
    }
	
    $RPVariable = Get-AutomationVariable -Name $RecoveryPlanContext.RecoveryPlanName
    $RPVariable = $RPVariable | convertfrom-json
	
	"Configurations used by this Runbook for the Failover..."
    Write-Output $RPVariable

	"Determining if Failover or Failback..."
	Write-Output $RecoveryPlanContext.FailoverDirection
	
	"Configuring Script based on Direction of Failover..."
    if ($RecoveryPlanContext.FailoverDirection -eq "PrimaryToSecondary") { 
        $SQLVMRG = $RPVariable.SecondarySiteRG
        $SQLVMName = $RPVariable.SecondarySiteSQLVMName
        $Path = $RPVariable.SecondarySiteSQLPath
		$VM-EUS-PROD-SQLName = $RPVariable.PrimarySiteVM-EUS-PROD-SQLName
		$VMEUS-PROD-SQL2Name = $RPVariable.PrimarySiteVMEUS-PROD-SQL2Name
		$VM-EUS-PROD-SQLRG = $RPVariable.PrimarySiteRG
		$VMEUS-PROD-SQL2RG = $RPVariable.PrimarySiteRG
		        
        InlineScript {
            Write-output "Failing over from Primary Site to Secondary Site. The new Primary Replica is on:" $Using:SQLVMName
            Invoke-WebRequest $Using:ASRFailoverScriptPath -OutFile $Using:tempPath
            Invoke-AzVMRunCommand -ResourceGroupName $Using:SQLVMRG -VMName $Using:SQLVMName -ScriptPath $Using:tempPath -CommandId 'RunPowerShellScript'
            Write-output "Completed AG Failover to Secondary Site"

            Write-output "Resuming Data Movement on VM-EUS-PROD-SQL"
            Invoke-WebRequest $Using:ASRFailoverScriptPathVM-EUS-PROD-SQL -OutFile $Using:tempPath
            Invoke-AzVMRunCommand -ResourceGroupName $Using:VM-EUS-PROD-SQLRG -VMName $Using:VM-EUS-PROD-SQLName -ScriptPath $Using:tempPath -CommandId 'RunPowerShellScript'
            Write-output "Data Movement Resumed on VM-EUS-PROD-SQL"

            Write-output "Resuming Data Movement on VMEUS-PROD-SQL2"
            Invoke-WebRequest $Using:ASRFailoverScriptPathVMEUS-PROD-SQL2 -OutFile $Using:tempPath
            Invoke-AzVMRunCommand -ResourceGroupName $Using:VM-EUS-PROD-SQLRG -VMName $Using:VMEUS-PROD-SQL2Name -ScriptPath $Using:tempPath -CommandId 'RunPowerShellScript'
            Write-output "Data Movement Resumed on VMEUS-PROD-SQL2"
		}
    }
    else {
        $SQLVMRG = $RPVariable.PrimarySiteRG
        $SQLVMName = $RPVariable.PrimarySiteVM-EUS-PROD-SQLName
        $Path = $RPVariable.PrimarySiteSQLPath
        
        InlineScript {
            Write-output "Failing back from Secondary Site to Primary Site. The new Primary Replica is on VM-EUS-PROD-SQL"
            Invoke-WebRequest $Using:ASRFailBackScriptPath -OutFile $Using:tempPath
            Invoke-AzVMRunCommand -ResourceGroupName $Using:SQLVMRG -VMName $Using:SQLVMName -ScriptPath $Using:tempPath -CommandId 'RunPowerShellScript'
            Write-output "Completed AG Failback to Primary Site"
		}
    }
}
