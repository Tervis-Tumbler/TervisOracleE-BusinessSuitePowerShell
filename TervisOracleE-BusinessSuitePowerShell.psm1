$EBSEnvironments = [PSCustomObject]@{
    Name = "Production"
    Apps_ReadPasswordstateEntryGUID = "4d8c2876-48c9-4b02-93e2-445d4474fe1f"
    AppsPasswordstateEntryGUID = "b74efe68-1e38-4bde-8004-849ef0dd7fdf"
    RootPasswordstateEntryGUID = "fdd03454-d2c4-4fa4-90a5-3aeda18dd1d0"
    ApplmgrPasswordstateEntryGUID = "a50043d3-8e24-4f0c-99a9-d9498bb9d71d"
},
[PSCustomObject]@{
    Name = "Epsilon"
    Apps_ReadPasswordstateEntryGUID = "a9efbf4c-8343-422a-a1b2-e53f993edc98"
},
[PSCustomObject]@{
    Name = "Delta"
    Apps_ReadPasswordstateEntryGUID = "2b934bee-0d97-4883-8931-01f441549e4d"
    AppsPasswordstateEntryGUID = "46046d76-b60c-4874-9f26-b3b98d6a0c1c"
    RootPasswordstateEntryGUID = "cf55567b-29e4-43bc-8aed-e34fa96a74a4"
    ApplmgrPasswordstateEntryGUID = "f1a55876-98e2-4186-9890-be5b26eb7cb0"
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

    $OracleDatabaseEntry = Get-TervisPasswordstatePassword -GUID $Environment.Apps_ReadPasswordstateEntryGUID -PropertyMapName OracleDatabase
    $ConnectionString = $OracleDatabaseEntry | ConvertTo-OracleConnectionString
    $RootCredential = Get-TervisPasswordstatePassword -GUID $Environment.RootPasswordstateEntryGUID -AsCredential
    $AppsCredential = Get-TervisPasswordstatePassword -GUID $Environment.AppsPasswordstateEntryGUID -AsCredential
    $ApplmgrCredential = Get-TervisPasswordstatePassword -GUID $Environment.ApplmgrPasswordstateEntryGUID -AsCredential
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