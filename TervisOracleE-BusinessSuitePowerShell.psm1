$EBSEnvironments = [PSCustomObject]@{
    Name = "Production"
    Apps_ReadPasswordstateEntryID = 4624
    AppsPasswordstateEntryID = 469
    RootPasswordstateEntryID = 294
    ApplmgrPasswordstateEntryID = 3415
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
    param (
        $Name
    )
    $EBSEnvironments |
    Where-Object {-not $Name -or $_.Name -eq $Name}
}

function Get-TervisEBSPowershellConfiguration {
    param (
        [Parameter(Mandatory)]$Name
    )
    $Environment = Get-TervisEBSEnvironment | 
    Where-Object Name -EQ $Name

    $OracleDatabaseEntry = Get-PasswordstateOracleDatabasePassword -ID $Environment.Apps_ReadPasswordstateEntryID
    $ConnectionString = $OracleDatabaseEntry | ConvertTo-OracleConnectionString
    $RootCredential = Get-PasswordstatePassword -ID $Environment.RootPasswordstateEntryID -AsCredential
    $AppsCredential = Get-PasswordstatePassword -ID $Environment.AppsPasswordstateEntryID -AsCredential
    $ApplmgrCredential = Get-PasswordstatePassword -ID $Environment.ApplmgrPasswordstateEntryID -AsCredential
    $DNSRoot = "tervis.prv" #Get-ADDomain | Select-Object -ExpandProperty DNSRoot
    New-EBSPowershellConfiguration -DatabaseConnectionString $ConnectionString -AppsCredential $AppsCredential -InternetApplicationServerComputerName "ebsias.$($Environment.Name).$DNSRoot" -RootCredential $RootCredential -ApplmgrCredential $ApplmgrCredential
}

function Set-TervisEBSEnvironment {
    param (
        [Parameter(Mandatory)]$Name
    )
    $Configuration = Get-TervisEBSPowershellConfiguration -Name $Name
    Set-EBSPowershellConfiguration -Configuration $Configuration

    #Import-Module -Force -Prefix $Name -Name OracleE-BusinessSuitePowerShell
    #& "Set-$($Name)EBSPowershellConfiguration" -Configuration $Configuration
}

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