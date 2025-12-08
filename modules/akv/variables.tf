variable "rg_name" {
  description = "The name of the resource group"
  type        = string

  validation {
    condition     = length(var.rg_name) > 0
    error_message = "The resource group name must not be empty."
  }

  validation {
    condition     = startswith(var.rg_name, "RG-")
    error_message = "The resource group name must start with 'RG-'."
  }
}

variable "project_name" {
  description = "The name of the project, abbreviated"
  type = string

  validation {
    condition = length(var.project_name) == 3
    error_message = "The project name must be 3 characters long."
  }

  validation {
    condition = lower(var.project_name) == var.project_name
    error_message = "The project name must be in all lower case."
  }
}

variable "environment" {
  description = "The name of the environment"
  type = string

  validation {
    condition = contains(["dev", "tst", "prd"], var.environment)
    error_message = "The environment must be one of 'dev', 'tst', or 'prd'."
  }
}

variable "sku" {
    description = "The SKU for the resources"
    type        = string
    default     = "standard"

    validation {
        condition     = contains(["standard", "premium"], var.sku)
        error_message = "The SKU must be either 'standard' or 'premium'."
    }
}

variable "certificate_permissions" {
  description = "List of key permissions for the key vault access policy"
  type        = list(string)
  validation {
    condition     = alltrue([for p in var.certificate_permissions : contains(["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"], p)])
    error_message = "Certificate permissions must be one of 'Backup', 'Create', 'Delete', 'DeleteIssuers', 'Get', 'GetIssuers', 'Import', 'List', 'ListIssuers', 'ManageContacts', 'ManageIssuers', 'Purge', 'Recover', 'Restore', 'SetIssuers', 'Update'."
  }

  validation {
    condition = length(var.certificate_permissions) == length(distinct(var.certificate_permissions))
    error_message = "Certificate permissions must not contain duplicate values."
  }
}

variable "key_permissions" {
  description = "List of key permissions for the key vault access policy"
  type        = list(string)
  validation {
    condition     = alltrue([for p in var.key_permissions : contains(["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"], p)])
    error_message = "Key permissions must be one of 'Backup', 'Create', 'Decrypt', 'Delete', 'Encrypt', 'Get', 'Import', 'List', 'Purge', 'Recover', 'Restore', 'Sign', 'UnwrapKey', 'Update', 'Verify', 'WrapKey', 'Release', 'Rotate', 'GetRotationPolicy', or 'SetRotationPolicy'."
  }

  validation {
    condition = length(var.key_permissions) == length(distinct(var.key_permissions))
    error_message = "Key permissions must not contain duplicate values."
  }
}

variable "secret_permissions" {
  description = "List of secret permissions for the key vault access policy"
  type        = list(string)

  validation {
    condition     = alltrue([for p in var.secret_permissions : contains(["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"], p)])
    error_message = "Secret permissions must be one of 'Backup', 'Delete', 'Get', 'List', 'Purge', 'Recover', 'Restore', or 'Set'."
  }

  validation {
    condition = length(var.secret_permissions) == length(distinct(var.secret_permissions))
    error_message = "Secret permissions must not contain duplicate values."
  }
}

variable "storage_permissions" {
  description = "List of storage permissions for the key vault access policy"
  type        = list(string)

  validation {
    condition     = alltrue([for p in var.storage_permissions : contains(["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"], p)])
    error_message = "Storage permissions must be one of 'Backup', 'Delete', 'DeleteSAS', 'Get', 'GetSAS', 'List', 'ListSAS', 'Purge', 'Recover', 'RegenerateKey', 'Restore', 'Set', 'SetSAS', or 'Update'."
  }

  validation {
    condition = length(var.storage_permissions) == length(distinct(var.storage_permissions))
    error_message = "Storage permissions must not contain duplicate values."
  }
}

variable "cost_center" {
  description = "The cost center tag value"
  type        = string

  validation {
    condition     = length(var.cost_center) > 0 && length(trimspace(var.cost_center)) <= 6
    error_message = "The cost center must be between 1 and 6 characters."
  }

  validation {
    condition = can(regex("^[0-9]+$", var.cost_center))
    error_message = "The cost center must only contain numeric characters."
  }
}

variable "owner" {
  description = "The owner of the application"
  type        = string

  validation {
    condition     = strcontains(var.owner, "@")
    error_message = "The owner must be a valid email address."
  }
}

variable "business_unit" {
  description = "The business unit tag value"
  type        = string

  validation {
    condition     = contains(["Finance", "HR", "IT", "Marketing", "Sales", "Operations"], var.business_unit)
    error_message = "The business unit must be one of 'Finance', 'HR', 'IT', 'Marketing', 'Sales', or 'Operations'."
  }
}