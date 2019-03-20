$SQLCommand = @"
DECLARE
AccountName VARCHAR2(200);
ProfileID NUMBER;
BEGIN
dbms_output.enable;
AccountName := 'John Smith';
ProfileID := 12345;
dbms_output.put_line(AccountName || ';' || ProfileID);
dbms_output.get_line(:Buffer,:Status);
END;
"@

Set-TervisEBSEnvironment -Name Delta 
$ConnectionString = (Get-EBSPowershellConfiguration).DatabaseConnectionString
$DatabaseEngineClassMapName = "Oracle"
$Connection = New-Object -TypeName "$NameSpace.$($ClassMap.Connection)" $ConnectionString
$Connection.Open()

$Command = New-Object "$NameSpace.$($ClassMap.Command)"
$InputVar1 = New-Object -TypeName Oracle.ManagedDataAccess.Client.OracleParameter -Property @{ParameterName = 'InputVar1';
        OracleDbType = 'VARCHAR2';Size = 2000;Direction = 'Input';Value = 'InputVariable'}
        $Command.Parameters.Add($InputVar1)
$Buffer = New-Object -TypeName Oracle.ManagedDataAccess.Client.OracleParameter -Property @{ParameterName = 'Buffer';
        OracleDbType = 'VARCHAR2';Size = 2000;Direction = 'Output';}
        $Command.Parameters.Add($Buffer)
$Status = New-Object -TypeName Oracle.ManagedDataAccess.Client.OracleParameter -Property @{ParameterName = 'Status';
        OracleDbType = 'INT32';Direction = 'Output';}
        $Command.Parameters.Add($Status)

$command.CommandType = "text"
$command.CommandText = $SQLCommand
$command.Connection = $Connection
$Command.BindByName = $true

$Adapter = New-Object "$NameSpace.$($ClassMap.Adapter)" $Command
$Dataset = New-Object System.Data.DataSet
$Adapter.Fill($DataSet) | Out-Null

$ReturnData = $Buffer.Value.Value | ConvertFrom-String -Delimiter ";" -PropertyNames AccountName,ProfileID

$ReturnData