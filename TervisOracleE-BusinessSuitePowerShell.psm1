﻿$EBSEnvironments = [PSCustomObject]@{
    Name = "Production"
    Apps_ReadPasswordstateEntryGUID = "4d8c2876-48c9-4b02-93e2-445d4474fe1f"
    AppsPasswordstateEntryGUID = "b74efe68-1e38-4bde-8004-849ef0dd7fdf"
    RootPasswordstateEntryGUID = "fdd03454-d2c4-4fa4-90a5-3aeda18dd1d0"
    ApplmgrPasswordstateEntryGUID = "a50043d3-8e24-4f0c-99a9-d9498bb9d71d"
    SysPasswordstateEntryGUID = "d9331490-fa99-46ca-8a9c-367013d6d86f"
},
[PSCustomObject]@{
    Name = "Epsilon"
    Apps_ReadPasswordstateEntryGUID = "a9efbf4c-8343-422a-a1b2-e53f993edc98"
    AppsPasswordstateEntryGUID = "efba22a9-4afe-4f46-afe1-f3c598738fb4"
    RootPasswordstateEntryGUID = "705e179e-74a0-4731-b4f8-9277202af854"
    ApplmgrPasswordstateEntryGUID = "fff258b6-9585-4c43-9f7d-785523df7b56"
    SysPasswordstateEntryGUID = "de3740e2-67b4-4342-821b-65998a46a2c3"
},
[PSCustomObject]@{
    Name = "Delta"
    Apps_ReadPasswordstateEntryGUID = "2b934bee-0d97-4883-8931-01f441549e4d"
    AppsPasswordstateEntryGUID = "46046d76-b60c-4874-9f26-b3b98d6a0c1c"
    RootPasswordstateEntryGUID = "cf55567b-29e4-43bc-8aed-e34fa96a74a4"
    ApplmgrPasswordstateEntryGUID = "f1a55876-98e2-4186-9890-be5b26eb7cb0"
    SysPasswordstateEntryGUID = "e6a0f22d-60e3-47aa-8cf3-4c731280a2b7"
},
[PSCustomObject]@{
    Name = "Zeta"
    AppsPasswordstateEntryGUID = "dc6b714e-3149-4679-a7d0-d6fc8f401457"
    Apps_ReadPasswordstateEntryGUID = "13b5f6b5-5a2b-4fd9-98b3-464ce06881bf"
    SysPasswordstateEntryGUID = "5a603bb4-7749-43e3-ac20-446a500c0e39"
    RootPasswordstateEntryGUID = "fdd03454-d2c4-4fa4-90a5-3aeda18dd1d0"
    ApplmgrPasswordstateEntryGUID = "42fdfa15-a3a8-426a-8bbb-0ffc5e04f693"
}

function Get-TervisEBSEnvironment {
    param (
        $Name
    )
    $EBSEnvironments |
    Where-Object {-not $Name -or $_.Name -eq $Name}
}

function    Get-TervisEBSPowershellConfiguration {
    param (
        [Parameter(Mandatory)]$Name
    )
    $Environment = Get-TervisEBSEnvironment |
    Where-Object Name -EQ $Name

    $OracleDatabaseEntry = Get-TervisPasswordstatePassword -GUID $Environment.AppsPasswordstateEntryGUID -PropertyMapName OracleDatabase
    $ConnectionString = $OracleDatabaseEntry | ConvertTo-OracleConnectionString
    $RootCredential = Get-TervisPasswordstatePassword -GUID $Environment.RootPasswordstateEntryGUID -AsCredential
    $AppsCredential = Get-TervisPasswordstatePassword -GUID $Environment.AppsPasswordstateEntryGUID -AsCredential
    $ApplmgrCredential = Get-TervisPasswordstatePassword -GUID $Environment.ApplmgrPasswordstateEntryGUID -AsCredential
    $SysCredential = Get-TervisPasswordstatePassword -GUID $Environment.SysPasswordstateEntryGUID -AsCredential
    $DNSRoot = "tervis.prv" #Get-ADDomain | Select-Object -ExpandProperty DNSRoot
    New-EBSPowershellConfiguration -DatabaseConnectionString $ConnectionString -AppsCredential $AppsCredential -InternetApplicationServerComputerName "ebsias.$($Environment.Name).$DNSRoot" -RootCredential $RootCredential -ApplmgrCredential $ApplmgrCredential -SysCredential $SysCredential
}

function Set-TervisEBSEnvironment {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]$Name
    )
    $Configuration = Get-TervisEBSPowershellConfiguration -Name $Name
    Set-EBSPowershellConfiguration -Configuration $Configuration

    #Import-Module -Force -Prefix $Name -Name OracleE-BusinessSuitePowerShell
    #& "Set-$($Name)EBSPowershellConfiguration" -Configuration $Configuration
}

function Invoke-TervisEBSResponsibilityAnalysis {
    $EBSUserNamesAndResponsibility = Get-EBSUserNameAndResponsibility
    $EBSUserNamesAndResponsibility | group RESPONSIBILITY_NAME | sort count
    Get-ADGroup -Filter {name -like "*Customer Service*"}
    $Members = Get-ADGroupMember -Identity "Customer Service Reps"
    $Members += Get-ADGroupMember -Identity "Returns Department"

    $ResponsibilitiesOfDTCAndReturns = $EBSUserNamesAndResponsibility |
    Where-Object USER_NAME -in $Members.samaccountname

    $ResponsibilitiesOfDTCAndReturns.User_Name | Sort-Object -Unique | measure

    compare ($ResponsibilitiesOfDTCAndReturns.User_Name | Sort-Object -Unique ) ($Members.samaccountname)

    $Members.samaccountname
    $Members | measure

    $ResponsibilitiesOfDTCAndReturns.Responsibility_Name | Sort-Object -Unique | measure

    $ResponsibilitiesOfDTCAndReturns | group Responsibility_Name | Sort-Object Count -Descending

    $EBSUserNamesAndResponsibility | Where-Object Responsibility_Name -EQ "Tervis OM User" | Select-Object User_Name | measure
}

Function New-EBSCustomerRecord {
    param(
        [parameter(ValueFromPipeline)]$CustomerBillToInformation,
        [parameter(ValueFromPipeline)]$CustomerShipToInformation,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$created_by_module,
        [parameter(mandatory,ValueFromPipelineByPropertyName)]$price_list_name,
        [parameter(mandatory,ValueFromPipelineByPropertyName)]$order_type,
        [parameter(mandatory,ValueFromPipelineByPropertyName)]$CustomerClass,
        [parameter(mandatory,ValueFromPipelineByPropertyName)]$SalesRepName,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$BlindShipmentFlag,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$OrganizationName,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$AccountName,
        [parameter(ValueFromPipelineByPropertyName)]$AccountNumber,
        [parameter(ValueFromPipelineByPropertyName)]$CustomerType,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$FOBPoint,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$Ship_Sets_Include_Lines_Flag,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$ShipVia,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$FreightTerms,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$SalesChannel,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$ShipToSiteSameAsBill,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$Site_Ship_Sets_Include_Lines_Flag,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$SiteShipVia,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$SiteBlindShipmentFlag,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$SiteFOBPoint,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$SiteFreightTerms,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$SiteSalesChannel,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$FNDUserID,
        $EBSEnvironmentConfiguration = (Get-EBSPowershellConfiguration)
    )
    Process{
        $ConnectionString = (Get-EBSPowershellConfiguration).DatabaseConnectionString
        $PriceListHeaderID = (Get-EBSTradingCommunityArchitectureListHeaders -list_type_code PRL -Name $price_list_name).LIST_HEADER_ID
        $OrderTransactionTypeID = (Get-EBSTradingCommunityArchitectureTransactionTypesTL -Name $order_type).Transaction_Type_ID
        $SalesRep_ID = (Get-EBSTradingCommunityArchitectureSalesRep -Name $SalesRepName).SalesRep_ID
        $CustomerRecord = Invoke-HZCustAccountV2PubCreateCustAccount -organization_name $OrganizationName `
            -created_by_module $created_by_module `
            -account_name $AccountName `
            -p_account_number $AccountNumber `
            -customer_type $CustomerType `
            -customer_class_code $CustomerClass `
            -fob_point $FOBPoint `
            -freight_term $FreightTerms `
            -sales_channel_code $SalesChannel `
            -price_list_id $PriceListHeaderID `
            -ship_via $ShipVia `
            -SHIP_SETS_INCLUDE_LINES_FLAG $Ship_Sets_Include_Lines_Flag `
            -attribute9 $BlindShipmentFlag
        $BillToLocationId = ($CustomerBillToInformation | Invoke-HZLocationV2PubCreateLocation -created_by_module $created_by_module).x_location_id
        if($ShipToSiteSameAsBill){
            $ShipToLocationID = ($CustomerBillToInformation | Invoke-HZLocationV2PubCreateLocation -created_by_module $created_by_module).x_location_id
        }
        ELSE{
            $ShipToLocationID = ($CustomerShipToInformation | Invoke-HZLocationV2PubCreateLocation -created_by_module $created_by_module).x_location_id
        }
        $BillToSite = Invoke-HZPartySiteV2PubCreatePartySite -party_id $CustomerRecord.x_party_id `
            -location_id $BillToLocationId `
            -identifying_address_flag "Y" `
            -created_by_module $created_by_module
        $ShipToSite = Invoke-HZPartySiteV2PubCreatePartySite -party_id $CustomerRecord.x_party_id `
            -location_id $ShipToLocationID `
            -identifying_address_flag "N" `
            -created_by_module $created_by_module
        $BillToAccountSite = Invoke-HZCustAccountSiteV2PubCreateCustAcctSite -cust_acct_id $CustomerRecord.x_cust_account_id -party_site_id  $BillToSite.x_party_site_id -created_by_module $created_by_module -FNDUserID $FNDUserID
        $ShipToAccountSite = Invoke-HZCustAccountSiteV2PubCreateCustAcctSite -cust_acct_id $CustomerRecord.x_cust_account_id $ShipToSite.x_party_site_id -created_by_module $created_by_module -FNDUserID $FNDUserID

        $BillToCustAccountSiteID = (Invoke-hzcustaccountsitev2pubcreatecustsiteuse -cust_acct_site_id $BillToAccountSite.x_cust_acct_site_id `
            -site_use_code "BILL_TO" `
            -primary_salesrep_id $SalesRep_ID `
            -order_type_id $OrderTransactionTypeID `
            -price_list_id $PriceListHeaderID `
            -fob_point $FOBPoint `
            -freight_term $FreightTerms `
            -ship_via $SiteShipVia `
            -SHIP_SETS_INCLUDE_LINES_FLAG $Ship_Sets_Include_Lines_Flag `
            -created_by_module $created_by_module `
            -attribute9 $SiteBlindShipmentFlag).x_site_use_id
        $ShipToCustAccountSiteID = (Invoke-hzcustaccountsitev2pubcreatecustsiteuse -cust_acct_site_id $ShipToAccountSite.x_cust_acct_site_id  `
            -site_use_code "SHIP_TO" `
            -primary_salesrep_id $SalesRep_ID `
            -order_type_id $OrderTransactionTypeID `
            -price_list_id $PriceListHeaderID `
            -fob_point $SiteFOBPoint `
            -freight_term $SiteFreightTerms `
            -ship_via $SiteShipVia `
            -SHIP_SETS_INCLUDE_LINES_FLAG $Site_Ship_Sets_Include_Lines_Flag `
            -created_by_module $created_by_module).x_site_use_id
        $BillToSiteContact = Invoke-HZPartyV2PubCreatePerson -person_pre_name_adjunct $CustomerBillToInformation.Sirname `
            -person_first_name $CustomerBillToInformation.FirstName `
            -person_last_name $CustomerBillToInformation.LastName `
            -created_by_module $created_by_module
        $ShipToSiteContact = Invoke-HZPartyV2PubCreatePerson -person_pre_name_adjunct $CustomerShipToInformation.Sirname `
            -person_first_name $CustomerShipToInformation.FirstName `
            -person_last_name $CustomerShipToInformation.LastName `
            -created_by_module $created_by_module
        $BillToOrgContactPerson = Invoke-HZPartyContactV2PubCreateOrgContact -subject_id $BillToSiteContact.x_party_id `
            -object_id $CustomerRecord.x_party_id `
            -subject_type 'PERSON' `
            -subject_table_name 'HZ_PARTIES' `
            -object_type "ORGANIZATION" `
            -object_table_name "HZ_PARTIES" `
            -relationship_code "CONTACT_OF" `
            -relationship_type "CONTACT" `
            -created_by_module $created_by_module
        $ShipToOrgContactPerson = Invoke-HZPartyContactV2PubCreateOrgContact -subject_id $ShipToSiteContact.x_party_id `
            -object_id $CustomerRecord.x_party_id `
            -subject_type 'PERSON' `
            -subject_table_name 'HZ_PARTIES' `
            -object_type "ORGANIZATION" `
            -object_table_name "HZ_PARTIES" `
            -relationship_code "CONTACT_OF" `
            -relationship_type "CONTACT" `
            -created_by_module $created_by_module
        $BillToAccountRole = Invoke-HZCustAccountRoleV2PubCreateCustAccountRole -party_id $BillToOrgContactPerson.x_party_id `
            -cust_account_id $CustomerRecord.x_cust_account_id `
            -cust_acct_site_id $BillToAccountSite.x_cust_acct_site_id `
            -primary_flag 'Y' `
            -role_type 'CONTACT' `
            -created_by_module $created_by_module `
            -FNDUserID $FNDUserID
        $ShipToAccountRole = Invoke-HZCustAccountRoleV2PubCreateCustAccountRole -party_id $ShipToOrgContactPerson.x_party_id `
            -cust_account_id $CustomerRecord.x_cust_account_id `
            -cust_acct_site_id $ShipToAccountSite.x_cust_acct_site_id `
            -primary_flag 'Y' `
            -role_type 'CONTACT' `
            -created_by_module $created_by_module `
            -FNDUserID $FNDUserID
        $BillingContactPointID = Invoke-HZContactPointV2PubCreateContactPoint -owner_table_name "HZ_PARTY_SITES" `
            -owner_table_id $BillToSite.x_party_site_id `
            -contact_point_type 'PHONE' `
            -phone_line_type $CustomerBillToInformation.PhoneLineType `
            -phone_area_code $CustomerBillToInformation.PhoneAreaCode `
            -Phone_number $CustomerBillToInformation.PhoneNumber `
            -created_by_module $created_by_module
        $ShippingContactPointID = Invoke-HZContactPointV2PubCreateContactPoint -owner_table_name "HZ_PARTY_SITES" `
            -owner_table_id $ShipToSite.x_party_site_id `
            -contact_point_type 'PHONE' `
            -phone_line_type $CustomerShipToInformation.PhoneLineType `
            -phone_area_code $CustomerShipToInformation.PhoneAreaCode `
            -Phone_number $CustomerShipToInformation.PhoneNumber `
            -created_by_module $created_by_module
        $ShipToEmailContactPointID = Invoke-HZContactPointV2PubCreateContactPoint -owner_table_name "HZ_PARTY_SITES" `
            -owner_table_id $ShipToSite.x_party_site_id `
            -contact_point_type 'EMAIL' `
            -email_format 'MAILHTML' `
            -email_address $CustomerShipToInformation.EmailAddress `
            -created_by_module $created_by_module
        $BillToResponsabilityID = Invoke-HZCustAccountRoleV2PubCreateRoleResponsibility `
            -cust_account_role_id $BillToAccountRole.x_cust_account_role_id `
            -responsibility_type 'BILL_TO' `
            -created_by_module $created_by_module
        $ShipToResponsabilityID = Invoke-HZCustAccountRoleV2PubCreateRoleResponsibility `
            -cust_account_role_id $ShipToAccountRole.x_cust_account_role_id `
            -responsibility_type 'SHIP_TO' `
            -created_by_module $created_by_module
        [PSCustomObject]@{
            CustomerAccount = [PSCustomObject]@{
                cust_account_id = $CustomerRecord.x_cust_account_id
                account_number = $CustomerRecord.x_account_number
                party_id = $CustomerRecord.x_party_id
                party_number = $CustomerRecord.x_party_number
                cust_profile_id = $CustomerRecord.x_cust_profile_id
            }
            BillToLocation = [PSCustomObject]@{
                Location_id = $BillToLocationId
            }
            ShipToLocation = [PSCustomObject]@{
                Location_id = $ShipToLocationId
            }
            BillToSite = [PSCustomObject]@{
                party_site_id = $BillToSite.x_party_site_id
                party_site_number = $BillToSite.x_party_site_number
            }
            ShipToSite = [PSCustomObject]@{
                party_site_id = $ShipToSite.x_party_site_id
                party_site_number = $ShipToSite.x_party_site_number
            }
            BillToAccountSite = [PSCustomObject]@{
                cust_acct_site_id = $BillToAccountSite.x_cust_acct_site_id
            }
            ShipToAccountSite = [PSCustomObject]@{
                cust_acct_site_id = $ShipToAccountSite.x_cust_acct_site_id
            }
            BillToCustAccountSite = [PSCustomObject]@{
                cust_acct_siteid = $BillToCustAccountSiteID
            }
            ShipToCustAccountSite = [PSCustomObject]@{
                cust_acct_siteid = $ShipToCustAccountSiteID
            }
            BillToSiteContact = [PSCustomObject]@{
                party_id = $BillToSiteContact.x_party_id
                party_number = $BillToSiteContact.x_party_number
                profile_id = $BillToSiteContact.x_profile_id
            }
            ShipToSiteContact = [PSCustomObject]@{
                party_id = $ShipToSiteContact.x_party_id
                party_number = $ShipToSiteContact.x_party_number
                profile_id = $ShipToSiteContact.x_profile_id
            }
            BillToOrgContactPerson = [PSCustomObject]@{
                org_contact_id = $BillToOrgContactPerson.x_org_contact_id
                party_id = $BillToOrgContactPerson.x_party_id
                party_number = $BillToOrgContactPerson.x_party_number
                party_rel_id = $BillToOrgContactPerson.x_party_rel_id
            }
            ShipToOrgContactPerson = [PSCustomObject]@{
                org_contact_id = $ShipToOrgContactPerson.x_org_contact_id
                party_id = $ShipToOrgContactPerson.x_party_id
                party_number = $ShipToOrgContactPerson.x_party_number
                party_rel_id = $ShipToOrgContactPerson.x_party_rel_id
            }
            BillToAccountRole = [PSCustomObject]@{
                cust_account_role_id = $BillToAccountRole.x_cust_account_role_id
            }
            ShipToAccountRole = [PSCustomObject]@{
                cust_account_role_id = $ShipToAccountRole.x_cust_account_role_id
            }
            BilltoContactPoint = [PSCustomObject]@{
                contact_point_id = $BillingContactPointID.x_contact_point_id
            }
            ShipToContactPoint = [PSCustomObject]@{
                contact_point_id = $ShippingContactPointID.x_contact_point_id
            }
            ShipToContactPointEmail = [PSCustomObject]@{
                contact_point_id = $ShipToEmailContactPointID.x_contact_point_id
            }
            BillToResponsability = [PSCustomObject]@{
                responsibility_id = $BillToResponsabilityID.x_responsibility_id
            }
            ShipToResponsability = [PSCustomObject]@{
                responsibility_id = $ShipToResponsabilityID.x_responsibility_id
            }
        }
    }
}

