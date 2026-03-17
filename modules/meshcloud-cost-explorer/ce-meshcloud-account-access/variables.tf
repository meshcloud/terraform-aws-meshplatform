variable "management_account_service_role_name" {
  type        = string
  default     = "MeshCostExplorerServiceRole"
  description = "Name of the custom role in the management account used by the cost explorer user."
}

variable "meshcloud_account_service_user_name" {
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
  description = "Set to false to skip creating static IAM access keys for the service account. Should be set to false when workload_identity_federation is configured."
  default     = true
}

variable "workload_identity_federation" {
  type = object({
    issuer                = string,
    audience              = string,
    subject               = string,
    identity_provider_arn = string
  })
  default     = null
  description = "Set to configure Workload Identity Federation. When set, a federated IAM role is created allowing authentication via OIDC instead of static access keys."
}
