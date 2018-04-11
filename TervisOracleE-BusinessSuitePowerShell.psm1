$EBSEnvironments = [PSCustomObject]@{
    Name = "Production"
    Apps_ReadPasswordstateEntryID = 4624
},
[PSCustomObject]@{
    Name = "Epsilon"
    Apps_ReadPasswordstateEntryID = 2669
},
[PSCustomObject]@{
    Name = "Delta"
    Apps_ReadPasswordstateEntryID = 2852
    AppsPasswordstateEntryID = 2725
    RootPasswordstateEntryID = 4691
    ApplmgrPasswordstateEntryID = 4771
}

function Get-TervisEBSEnvironment {
    $EBSEnvironments
}

function Set-TervisEBSEnvironment {
    param (
        [Parameter(Mandatory)]$Name
    )
    $Environment = Get-TervisEBSEnvironment | 
    Where-Object Name -EQ $Name

    $OracleDatabaseEntry = Get-PasswordstateOracleDatabaseEntryDetails -PasswordID $Environment.Apps_ReadPasswordstateEntryID
    $ConnectionString = $OracleDatabaseEntry | ConvertTo-OracleConnectionString
    $RootCredential = Get-PasswordstateCredential -PasswordID $Environment.RootPasswordstateEntryID
    $AppsCredential = Get-PasswordstateCredential -PasswordID $Environment.AppsPasswordstateEntryID
    $ApplmgrCredential = Get-PasswordstateCredential -PasswordID $Environment.ApplmgrPasswordstateEntryID
    $DNSRoot = Get-ADDomain | Select-Object -ExpandProperty DNSRoot
    $Configuration = New-EBSPowershellConfiguration -DatabaseConnectionString $ConnectionString -AppsCredential $AppsCredential -InternetApplicationServerComputerName "ebsias.$($Environment.Name).$DNSRoot" -RootCredential $RootCredential -ApplmgrCredential $ApplmgrCredential
    
    Set-EBSPowershellConfiguration -Configuration $Configuration

    #Import-Module -Force -Prefix $Name -Name OracleE-BusinessSuitePowerShell
    #& "Set-$($Name)EBSPowershellConfiguration" -Configuration $Configuration
}

Set-TervisEBSEnvironment -Name Delta

function Invoke-TervisEBSResponsibilityAnalysis {
    $EBSUserNamesAndResponsibility = Get-EBSUserNameAndResponsibility
    $EBSUserNamesAndResponsibility | group RESPONSIBILITY_NAME | sort count
    Get-ADGroup -Filter {name -like "*Customer Service*"}
    $Members = Get-ADGroupMember -Identity "Customer Service Reps"
    $Members += Get-ADGroupMember -Identity "Returns Department"

    $ResponsibilitiesOfDTCAndReturns = $EBSUserNamesAndResponsibility | 
    Where-Object USER_NAME -in $Members.samaccountname

    $ResponsibilitiesOfDTCAndReturns.User_Name | Sort-Object -Unique | measure

    compare ($ResponsibilitiesOfDTCAndReturns.User_Name | Sort-Object -Unique ) ($Members.samaccountname)

    $Members.samaccountname
    $Members | measure

    $ResponsibilitiesOfDTCAndReturns.Responsibility_Name | Sort-Object -Unique | measure

    $ResponsibilitiesOfDTCAndReturns | group Responsibility_Name | Sort-Object Count -Descending

    $EBSUserNamesAndResponsibility | Where-Object Responsibility_Name -EQ "Tervis OM User" | Select-Object User_Name | measure
}