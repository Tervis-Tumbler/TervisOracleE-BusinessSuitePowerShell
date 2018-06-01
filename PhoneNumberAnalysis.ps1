
Set-TervisEBSEnvironment -Name Delta
$EBSEnvironmentConfiguration = (Get-EBSPowershellConfiguration)
$SQLCommand =  @"
SELECT
    PHONE_AREA_CODE,
    PHONE_NUMBER,
    RAW_PHONE_NUMBER
FROM hz_contact_points
"@

$Results = Invoke-OracleSQL -ConnectionString $EBSEnvironmentConfiguration.DatabaseConnectionString -SQLCommand $SQLCommand
$Results | Export-clixml -Path .\results.xml
$Results | convertto-json | out-file -FilePath results.json -Encoding ascii
$Results[10000] | convertto-json
$Var = $Results[10000]
$Var | ConvertTo-Json

$PSCustomObjects = $Results |
ConvertFrom-DataRow