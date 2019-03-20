$SQLCommand = @"
BEGIN
SELECT sysdate INTO :OutputVar from dual;
END;
"@

Set-TervisEBSEnvironment -Name Delta 
$ConnectionString = (Get-EBSPowershellConfiguration).DatabaseConnectionString
$DatabaseEngineClassMapName = "Oracle"
$Connection = New-Object -TypeName "$NameSpace.$($ClassMap.Connection)" $ConnectionString
$Connection.Open()

$Command = New-Object "$NameSpace.$($ClassMap.Command)"
$OutputVar = New-Object -TypeName Oracle.ManagedDataAccess.Client.OracleParameter -Property @{ParameterName = 'OutputVar';
        OracleDbType = 'VARCHAR2';Size = 2000;Direction = 'Output';}
        $Command.Parameters.Add($OutputVar)

$command.CommandType = "text"
$command.CommandText = $SQLCommand
$command.Connection = $Connection
$Command.BindByName = $true

$Adapter = New-Object "$NameSpace.$($ClassMap.Adapter)" $Command
$Dataset = New-Object System.Data.DataSet
$Adapter.Fill($DataSet) | Out-Null

