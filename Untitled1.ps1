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

$Organization = Get-EBSOrganiztaionFromEmail -EmailAddress $EmailAddress | select -First 1

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


"Organization"
$Organization | ft *
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

