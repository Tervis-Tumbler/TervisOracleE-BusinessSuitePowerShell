$PLSQLStoredProcedure = @"
create or replace procedure OracleParameterTestProcedure(inputvar IN VARCHAR2,outputvar OUT VARCHAR2)
IS BEGIN
outputvar := 'Output Variable Test - ' || inputvar;
END;
/
"@


Set-TervisEBSEnvironment -Name Delta 
$ConnectionString = (Get-EBSPowershellConfiguration).DatabaseConnectionString
$DatabaseEngineClassMapName = "Oracle"
$ClassMap = Get-DatabaseEngineClassMap -Name $DatabaseEngineClassMapName
$NameSpace = $ClassMap.NameSpace
if ($ClassMap.AddTypeScriptBlock) { & $ClassMap.AddTypeScriptBlock }
$Connection = New-Object -TypeName "$NameSpace.$($ClassMap.Connection)" $ConnectionString
$Connection.Open()

$Command = New-Object "$NameSpace.$($ClassMap.Command)"
$Command = New-Object "$NameSpace.$($ClassMap.Command)"
$command.CommandType = "StoredProcedure"
$command.CommandText = "OracleParameterTestProcedure"
$command.Connection = $Connection
$Command.BindByName = $true
$Adapter = New-Object "$NameSpace.$($ClassMap.Adapter)" $Command
$Dataset = New-Object System.Data.DataSet

$OracleOutputParam = New-Object -TypeName Oracle.ManagedDataAccess.Client.OracleParameter
$OracleOutputParam.ParameterName = "outputvar"
$OracleOutputParam.OracleDbType = "VARCHAR2"
$OracleOutputParam.Size = "1000"
$OracleOutputParam.Direction = "output"
$OracleInputParam = New-Object -TypeName Oracle.ManagedDataAccess.Client.OracleParameter
$OracleInputParam.ParameterName = "inputvar"
$OracleInputParam.OracleDbType = "VARCHAR2"
$OracleInputParam.Size = "1000"
$OracleInputParam.Direction = "input"
$OracleInputParam.Value = "Input String Test"
$command.Parameters.Add($OracleOutputParam)
$command.Parameters.Add($OracleInputParam)

$Adapter.Fill($DataSet) | Out-Null
$Connection.Close()

$OracleInputParam
$OracleOutputParam
