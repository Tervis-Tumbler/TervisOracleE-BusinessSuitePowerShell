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

$FNDUserID = 1231

Set-TervisEBSEnvironment -Name Zeta
$Splatvariable = New-SplatVariable -Function New-EBSCustomerRecord -Variables (Get-Variable)
New-EBSCustomerRecord @Splatvariable
