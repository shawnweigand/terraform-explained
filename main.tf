module "akv" {
  source = "./modules/akv"

  rg_name         = var.rg_name
  sku             = var.sku
  project_name    = var.project_name
  environment     = var.environment
  cost_center     = var.cost_center
  owner           = var.owner
  business_unit   = var.business_unit
  certificate_permissions = var.certificate_permissions
  key_permissions = var.key_permissions
  secret_permissions = var.secret_permissions
  storage_permissions = var.storage_permissions

  providers = {
    azurerm = azurerm
  }
}

resource "azurerm_key_vault_secret" "secret" {
  name         = "${module.akv.akv.name}-sauce"
  value        = "szechuan"
  key_vault_id = module.akv.akv.id
}