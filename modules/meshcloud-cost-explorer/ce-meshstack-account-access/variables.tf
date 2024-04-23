variable "management_account_service_role_name" {
  type        = string
  default     = "MeshCostExplorerServiceRole"
  description = "Name of the custom role in the management account used by the cost explorer user."
}

variable "meshstack_account_service_user_name" {
  type        = string
  default     = "meshcloud-cost-explorer-user"
  description = "Name of the user using cost explorer service to collect metering data."
}

variable "management_account_id" {
  type        = string
  description = "The ID of the Management Account."
}

variable "privileged_external_id" {
  type        = string
  description = "Privileged external ID for the cost-explorer-service to use"
}

variable "create_access_key" {
  type        = bool
  description = "Create access key for service account"
  default     = true
}

variable "workload_identity_federation" {
  type = object({
    issuer                = string,
    audience              = string,
    subject               = string,
    identity_provider_arn = string
  })
  default = null
}
