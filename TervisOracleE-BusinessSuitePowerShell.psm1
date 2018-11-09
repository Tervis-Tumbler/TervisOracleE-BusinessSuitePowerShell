$EBSEnvironments = [PSCustomObject]@{
    Name = "Production"
    Apps_ReadPasswordstateEntryGUID = "4d8c2876-48c9-4b02-93e2-445d4474fe1f"
    AppsPasswordstateEntryGUID = "b74efe68-1e38-4bde-8004-849ef0dd7fdf"
    RootPasswordstateEntryGUID = "fdd03454-d2c4-4fa4-90a5-3aeda18dd1d0"
    ApplmgrPasswordstateEntryGUID = "a50043d3-8e24-4f0c-99a9-d9498bb9d71d"
    SysPasswordstateEntryGUID = "d9331490-fa99-46ca-8a9c-367013d6d86f"
},
[PSCustomObject]@{
    Name = "Epsilon"
    Apps_ReadPasswordstateEntryGUID = "a9efbf4c-8343-422a-a1b2-e53f993edc98"
    AppsPasswordstateEntryGUID = "efba22a9-4afe-4f46-afe1-f3c598738fb4"
    RootPasswordstateEntryGUID = "705e179e-74a0-4731-b4f8-9277202af854"
    ApplmgrPasswordstateEntryGUID = "fff258b6-9585-4c43-9f7d-785523df7b56"
    SysPasswordstateEntryGUID = "de3740e2-67b4-4342-821b-65998a46a2c3"
},
[PSCustomObject]@{
    Name = "Delta"
    Apps_ReadPasswordstateEntryGUID = "2b934bee-0d97-4883-8931-01f441549e4d"
    AppsPasswordstateEntryGUID = "46046d76-b60c-4874-9f26-b3b98d6a0c1c"
    RootPasswordstateEntryGUID = "cf55567b-29e4-43bc-8aed-e34fa96a74a4"
    ApplmgrPasswordstateEntryGUID = "f1a55876-98e2-4186-9890-be5b26eb7cb0"
    SysPasswordstateEntryGUID = "e6a0f22d-60e3-47aa-8cf3-4c731280a2b7"
},
[PSCustomObject]@{
    Name = "Zeta"
    Apps_ReadPasswordstateEntryGUID = "13b5f6b5-5a2b-4fd9-98b3-464ce06881bf"
    AppsPasswordstateEntryGUID = "dc6b714e-3149-4679-a7d0-d6fc8f401457"
    SysPasswordstateEntryGUID = "5a603bb4-7749-43e3-ac20-446a500c0e39"
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
    $SysCredential = Get-TervisPasswordstatePassword -GUID $Environment.SysPasswordstateEntryGUID -AsCredential
    $DNSRoot = "tervis.prv" #Get-ADDomain | Select-Object -ExpandProperty DNSRoot
    New-EBSPowershellConfiguration -DatabaseConnectionString $ConnectionString -AppsCredential $AppsCredential -InternetApplicationServerComputerName "ebsias.$($Environment.Name).$DNSRoot" -RootCredential $RootCredential -ApplmgrCredential $ApplmgrCredential -SysCredential $SysCredential
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