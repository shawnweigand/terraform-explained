mock_provider "azurerm" {
    mock_data "azurerm_client_config" {
        defaults = {
            tenant_id = "11111111-1111-1111-1111-111111111111"
            object_id = "22222222-2222-2222-2222-222222222222"
        }
    }
}

variables {
    rg_name         = "RG-Example"
    sku             = "standard"
    subscription_id = "00000000-0000-0000-0000-000000000000"
    key_permissions = ["Get", "List", "Create"]
    secret_permissions = ["Get", "List", "Set"]
    storage_permissions = ["Get", "List", "Set"]
}

run "validate_rg_name_min" {
    command = plan
    
    variables {
        rg_name = ""
    }

    expect_failures = [ 
        var.rg_name
    ]
}

run "validate_rg_name_start" {
    command = plan

    variables {
        rg_name = "ResourceGroup"
    }

    expect_failures = [ 
        var.rg_name
    ]
}

run "validate_sku" {
    command = plan

    variables {
        sku = "basic"
    }

    expect_failures = [ 
        var.sku
    ]
}

run "validate_permissions_invalid" {
    command = plan

    variables {
        key_permissions = ["Get", "InvalidPermission"]
        secret_permissions = ["Get", "InvalidPermission"]
        storage_permissions = ["Get", "InvalidPermission"]
    }

    expect_failures = [ 
        var.key_permissions,
        var.secret_permissions,
        var.storage_permissions
    ]
}

run "validate_permissions_duplicates" {
    command = plan

    variables {
        key_permissions = ["Get", "List", "Get"]
        secret_permissions = ["Get", "List", "Get"]
        storage_permissions = ["Get", "List", "Get"]
    }

    expect_failures = [ 
        var.key_permissions,
        var.secret_permissions,
        var.storage_permissions
    ]
}