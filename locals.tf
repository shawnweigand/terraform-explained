locals {
    key_vault_name = "akv${var.project_name}${var.environment}"
    tags = {
        Project      = var.project_name
        Environment  = var.environment
        CostCenter   = var.cost_center
        Owner        = var.owner
        BusinessUnit = var.business_unit
    }
}