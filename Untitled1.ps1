ipmo -Force OracleE-BusinessSuitePowerShell, TervisOracleE-BusinessSuitePowerShell, InvokeSQL
$Relationships = Get-EBSTradingCommunityArchitectureContactPoint -EmailAddress $EmailAddress |
ForEach-Object -Process {
    [PSCustomObject]@{
        Party_ID = $_.OWNER_TABLE_ID
    }
} |
Get-EBSTradingCommunityArchitectureRelationship

$ContactParty = $Relationships | 
where RELATIONSHIP_TYPE -EQ "Contact" |
ForEach-Object -Process {
    [PSCustomObject]@{
        Party_ID = $_.subject_id
    }
} |
Get-EBSTradingCommunityArchitectureParty

$CustomerAccount = $Relationships | 
where RELATIONSHIP_TYPE -EQ "Contact" |
ForEach-Object -Process {
    [PSCustomObject]@{
        Party_ID = $_.object_id
    }
} |
Get-EBSTradingCommunityArchitectureCustomerAccount

$OrganiztaionParty = $CustomerAccount |
Get-EBSTradingCommunityArchitectureParty


ipmo -Force OracleE-BusinessSuitePowerShell, TervisOracleE-BusinessSuitePowerShell, InvokeSQL

$OrganizationParty = Get-EBSOrganiztaionFromEmail -EmailAddress $EmailAddress | select -First 1

$Account = Get-EBSTradingCommunityArchitectureCustomerAccount -Party_ID $Organization.PARTY_ID
$AccountSites = $Account | Get-EBSTradingCommunityArchitectureCustomerAccountSite
$Relationships = Get-EBSTradingCommunityArchitectureRelationship -object_id $Organization.PARTY_ID
$AccountParties = $AccountRelationships | Get-EBSTradingCommunityArchitectureParty
$AccountRelationshipSubjectParties = $AccountRelationships |
ForEach-Object {
    Get-EBSTradingCommunityArchitectureParty -Party_ID $_.subject_id
}
$Sites = $Account | Get-EBSTradingCommunityArchitecturePartySite

$Contacts = $Relationships |
% {
  Get-EBSTradingCommunityArchitectureOrganiztaionContact -party_relationship_id $_.RELATIONSHIP_ID
}


"OrganizationParty"
$$OrganizationParty | ft *
"Account"
$Account | ft *
"AccountSites"
$AccountSites | ft *
"Relationships"
$Relationships | ft *
"AccountParties"
$AccountParties | ft *
"AccountRelationshipSubjectParties"
$AccountRelationshipSubjectParties | ft *
"Sites"
$Sites | ft *
"Contacts"
$Contacts | ft *

Remove-TypeData System.Array
ipmo -Force OracleE-BusinessSuitePowerShell, TervisOracleE-BusinessSuitePowerShell, InvokeSQL
$Organization = Get-EBSTradingCommunityArchitectureOrganizationObject -Party_ID 42924331
$Organization.Account.Site[0].Contact
$Organization | ConvertTo-Json -Depth 100


$ContatPoint1 = Get-EBSTradingCommunityArchitectureContactPoint -EmailAddress account2ndlevelfromaccount@email.com
$Party1 = Get-EBSTradingCommunityArchitectureParty -Party_ID $ContatPoint1.OWNER_TABLE_ID
$Party1Relationship = Get-EBSTradingCommunityArchitectureRelationship -Party_ID $Party1.PARTY_ID

$ContatPoint1
$Party1
$Party1Relationship

$ContatPoint2 = Get-EBSTradingCommunityArchitectureContactPoint -EmailAddress account2ndlevelFromOrg@email.com
$Party2 = Get-EBSTradingCommunityArchitectureParty -Party_ID $ContatPoint2.owner_table_id

$ContatPoint2
$Party2