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
    cost_center     = "123456"
    owner           = "owner@example.com"
    business_unit   = "IT"
    subscription_id = "00000000-0000-0000-0000-000000000000"
    certificate_permissions = ["Get", "List", "Create"]
    key_permissions = ["Get", "List", "Create"]
    secret_permissions = ["Get", "List", "Set"]
    storage_permissions = ["Get", "List", "Set"]
}

run "assert_akv_name" {
    command = plan

    assert {
        condition = startswith(local.key_vault_name, "akv")
        error_message = "Key Vault name must start with 'akv'"
    }

    assert {
      condition = strcontains(local.key_vault_name, var.environment) && strcontains(local.key_vault_name, var.project_name)
      error_message = "Key Vault name must contain the 'environment' and 'project name' variables'"
    }
}

run "assert_tags" {
    command = plan

    assert {
        condition = (contains(keys(local.tags), "Project") &&
                    contains(keys(local.tags), "Environment") &&
                    contains(keys(local.tags), "CostCenter") &&
                    contains(keys(local.tags), "Owner") &&
                    contains(keys(local.tags), "BusinessUnit"))
        error_message = "Tags must include Project, Environment, CostCenter, Owner, and BusinessUnit"
    }
}