Set-TervisEBSEnvironment -Name zeta

$CustomerBillToInformation = [PSCustomObject][ordered]@{
        Sirname = "MR."
        FirstName = "Don"
        LastName = "Mohlmaster"
        PhoneNumber = "216-2537"
        PhoneAreaCode = "941"
        PhoneLineType = "GEN"
        EmailAddress = "dmohlmaster@tervis.com"
        Address1 = "201 Triple Diamond Blvd."
        Address2 = "BillToAddressLine2"
        Address3 = "BillToAddressLine3"
        State = "FL"
        Country = "US"
        City = "North Venice"
        Postal_Code = "32075"
        Province = ""
}
$CustomerShipToInformation = [PSCustomObject][ordered]@{
        Sirname = "MR."
        FirstName = "Don"
        LastName = "Mohlmaster"
        PhoneNumber = "216-2537"
        PhoneAreaCode = "941"
        PhoneLineType = "GEN"
        EmailAddress = "dmohlmaster@tervis.com"
        Address1 = "201 Triple Diamond Blvd."
        Address2 = "ShipToAddressLine2"
        Address3 = "ShipToAddressLine3"
        State = "FL"
        Country = "US"
        City = "North Venice"
        Postal_Code = "32075"
        Province = ""
}

$BillToSirname = "MR."
$BillToFirstName = "Don"
$BillToLastName = "Mohlmaster"
$BillToPhoneNumber = "216-2537"
$BillToPhoneAreaCode = "941"
$BillToPhoneLineType = "GEN"
$BillToEmailAddress = "dmohlmaster@tervis.com"
$BillToAddress1 = "201 Triple Diamond Blvd."
$BillToAddress2 = "BillToAddressLine2"
$BillToAddress3 = "BillToAddressLine3"
$BillToState = "FL"
$BillToCountry = "US"
$BillToCity = "North Venice"
$BillToPostal_Code = "32075"
$BillToProvince = ""

$ShipToSirname = "MR."
$ShipToFirstName = "Don"
$ShipToLastName = "Mohlmaster"
$ShipToPhoneNumber = "216-2537"
$ShipToPhoneAreaCode = "941"
$ShipToPhoneLineType = "GEN"
$ShipToEmailAddress = "dmohlmaster@tervis.com"
$ShipToAddress1 = "201 Triple Diamond Blvd."
$ShipToAddress2 = "ShipToAddressLine2"
$ShipToAddress3 = "ShipToAddressLine3"
$ShipToState = "FL"
$ShipToCountry = "US"
$ShipToCity = "North Venice"
$ShipToPostal_Code = "32075"
$ShipToProvince = ""



$created_by_module = 'TCA_V1_API' #'TCA_FORM_WRAPPER'
$price_list_name = 'AMERICROWN'
$order_type = 'ITC Sales Order'
$CustomerClass = 'SPORTS'
$SalesRepName = 'EDWARDS, ALISSA'
$BlindShipmentFlag = 'YES'
$OrganizationName ='SRG0805_08 Party Name'
$AccountName = 'SRG00805_08'
$AccountNumber = ""
$CustomerType = "" 	
$FOBPoint = 'FACTORY'
$Ship_Sets_Include_Lines_Flag = "Y"
$ShipVia = '000001_ABF_L_LTL'
$FreightTerms = 'COLLECT'
$SalesChannel = 'INDIRECT' #;--'DIRECT'
$ShipToSiteSameAsBill = "N"

$Site_Ship_Sets_Include_Lines_Flag = "Y"
$SiteShipVia = '000001_ABF_L_LTL'
$SiteBlindShipmentFlag = 'YES'
$SiteFOBPoint = 'FACTORY'
$SiteFreightTerms = 'COLLECT'
$SiteSalesChannel = 'INDIRECT' #;--'DIRECT'

$FNDUserName = "DMOHLMASTER"
$FNDUserID = (Get-EBSFNDUser -user_name $FNDUserName).USER_ID

Set-TervisEBSEnvironment -Name zeta
$Splatvariable = New-SplatVariable -Function New-EBSCustomerRecord -Variables (Get-Variable)
$CustomerRecord = New-EBSCustomerRecord @Splatvariable




######################https://docs.oracle.com/cd/E26401_01/doc.122/e48943/T358453T358475.htm


#$HoldDefinition = Get-EBSTradingCommunityArchitectureHoldDefinition -Name "CustoMyzer Pending"
