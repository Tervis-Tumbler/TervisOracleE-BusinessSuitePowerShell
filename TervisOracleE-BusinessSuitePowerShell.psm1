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
}

function Set-TervisEBSEnvironment {
    param (
        [Parameter(Mandatory)]$Name
    )
    $Environment = $EBSEnvironments | 
    Where-Object Name -EQ $Name
    
    $OracleDatabaseEntry = Get-PasswordstateOracleDatabaseEntryDetails -PasswordID $Environment.Apps_ReadPasswordstateEntryID
    $ConnectionString = $OracleDatabaseEntry | ConvertTo-OracleConnectionString
    Set-EBSConnectionString -ConnectionString $ConnectionString
}

Set-TervisEBSEnvironment -Name Delta

function Invoke-TervisEBSResponsibilityAnalysis {
    $EBSUserNamesAndResponsibility = Get-EBSUserNameAndResponsibility
    $EBSUserNamesAndResponsibility | group RESPONSIBILITY_NAME | sort count
}