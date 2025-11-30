mock_provider "azurerm" {
    mock_data "azurerm_client_config" {
        defaults = {
            tenant_id = "11111111-1111-1111-1111-111111111111"
            object_id = "22222222-2222-2222-2222-222222222222"
        }
    }

    mock_data "azurem_resource_group" {
      defaults = {
        name = "RG-Example"
        location = "East US"
      }
    }
}

variables {
    rg_name         = "RG-Example"
    sku             = "standard"
    project_name    = "dem"
    environment     = "dev"
    subscription_id = "00000000-0000-0000-0000-000000000000"
    certificate_permissions = ["Get", "List", "Create"]
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

run "validate_project_name_length" {
    command = plan

    variables {
        project_name = "hi"
    }

    expect_failures = [ 
        var.project_name
     ]
}

run "validate_project_name_case" {
    command = plan

    variables {
        project_name = "TST"
    }

    expect_failures = [ 
        var.project_name
     ]
}


run "validate_environment" {
    command = plan

    variables {
        environment = "qa"
    }

    expect_failures = [ 
        var.environment
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
        certificate_permissions = ["Get", "InvalidPermission"]
        key_permissions = ["Get", "InvalidPermission"]
        secret_permissions = ["Get", "InvalidPermission"]
        storage_permissions = ["Get", "InvalidPermission"]
    }

    expect_failures = [
        var.certificate_permissions, 
        var.key_permissions,
        var.secret_permissions,
        var.storage_permissions
    ]
}

run "validate_permissions_duplicates" {
    command = plan

    variables {
        certificate_permissions = ["Get", "List", "Get"]
        key_permissions = ["Get", "List", "Get"]
        secret_permissions = ["Get", "List", "Get"]
        storage_permissions = ["Get", "List", "Get"]
    }

    expect_failures = [ 
        var.certificate_permissions,
        var.key_permissions,
        var.secret_permissions,
        var.storage_permissions
    ]
}