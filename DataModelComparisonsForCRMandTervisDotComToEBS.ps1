$EBSTCARecordsNeededForSalesOrderAcknowledgement = [PSCustomObject]@{
    Type = "Organization"
    Account = [PSCustomObject]@{
        Contact = @(
            [PSCustomObject]@{
                Email = @(
                    [PSCustomObject]@{
                        Primary = $true
                        Address = "email@domain.com"
                    }
                )
                Role = @(
                    [PSCustomObject]@{
                        Name = "Acknowledgements"
                    }
                )
            }
        )
    }
}

$EBSTCARecordsNeededForShipmentEmail = [PSCustomObject]@{
    Type = "Organization"
    Account = [PSCustomObject]@{
        Site = @(
            [PSCustomObject]@{
                Purpose = "Ship To"
                Contact = @(
                    [PSCustomObject]@{
                        Email = @(
                            [PSCustomObject]@{
                                Primary = $true
                                Address = "email@domain.com"
                            }
                        )
                    }
                )
            }
        )
    }
}

$EBSTCARecordsFromTervisDotCom = [PSCustomObject]@{
    Type = "Organization"
    
}

$EBSTCARecordsCustomerFromSalesOrderForm = [PSCustomObject]@{
    Type = "Organization"
    #Account = [
}

$TervisDotComLogicalDataModelForOrder = [PCustomObject]@{
    SFCCUniqueAccountID = "1234"
    AccountEmailAddress = "email@domain.com"
    ContactEmail = "email@domain.com"
    ShippingAddress = [PSCustomObject]@{
        FirstName = ""
        LastName = ""
        CompanyName = ""
        Address1 = ""
        Address2 = ""
        City = ""
        State = ""
        Zip = ""
        PhoneNumber = ""
    }
    BillingAddressSameAsShipping = $False
    BillingAddress = [PSCustomObject]@{
        FirstName = ""
        LastName = ""
        CompanyName = ""
        Address1 = ""
        Address2 = ""
        City = ""
        State = ""
        Zip = ""
        PhoneNumber = ""
    }
}