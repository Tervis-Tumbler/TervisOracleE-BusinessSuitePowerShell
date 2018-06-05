
Set-TervisEBSEnvironment -Name Delta
$EBSEnvironmentConfiguration = (Get-EBSPowershellConfiguration)
$SQLCommand =  @"
SELECT
    PHONE_AREA_CODE,
    PHONE_NUMBER,
    RAW_PHONE_NUMBER,
    TRANSPOSED_PHONE_NUMBER
FROM hz_contact_points
WHERE CONTACT_POINT_TYPE = 'PHONE'
"@

$SQLCommand =  @"
SELECT
    Party_Name,
    Person_Last_Name,
    Person_First_Name
FROM hz_parties
"@


$Results = Invoke-OracleSQL -ConnectionString $EBSEnvironmentConfiguration.DatabaseConnectionString -SQLCommand $SQLCommand

$Results.Count

$ResultsSubset = $Results | Select-Object -First 10000 -Skip 10000
$ResultsSubset.Count

$ResultsSubset | group PHONE_AREA_CODE
$Results  | group PHONE_AREA_CODE | sort count

[System.GC]::Collect()
$IndexesOfRandomSample = 1..16547 | %{ Get-Random -Maximum $Results.Count}

1..100 | %{ Get-Random -Maximum $Results.Count} | %{$Results[$_] }

$ResultsSubset = $Results[$IndexesOfRandomSample]

$ResultsSubset | group PHONE_AREA_CODE | sort count

$Results | Export-clixml -Path .\results.xml
$Results | convertto-json | out-file -FilePath results.json -Encoding ascii
$Results[10000] | convertto-json
$Var = $Results[10000]
$Var | ConvertTo-Json

$PSCustomObjects = $Results |
ConvertFrom-DataRow
