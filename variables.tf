variable "subscription_id" {
  description = "The subscription ID for the Azure provider"
  type        = string
}

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

variable "sku" {
    description = "The SKU for the resources"
    type        = string
    default     = "standard"

    validation {
        condition     = contains(["standard", "premium"], var.sku)
        error_message = "The SKU must be either 'standard' or 'premium'."
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