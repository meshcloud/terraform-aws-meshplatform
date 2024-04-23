variable "meshstack_account_service_user_name" {
  type        = string
  default     = "meshfed-service-user"
  description = "Name of the meshfed-service user. This user is responsible for replication."
}

variable "management_account_service_role_name" {
  type        = string
  default     = "MeshfedServiceRole"
  description = "Name of the custom role in the management account. See https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform-aws-manually.html#set-up-aws-account-2-management"
}

variable "management_account_id" {
  type        = string
  description = "The ID of the Management Account ID"
}

variable "automation_account_service_role_name" {
  type        = string
  default     = "MeshfedAutomationRole"
  description = "Name of the custom role in the automation account. See https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform-aws-manually.html#set-up-aws-account-3-automation"
}

variable "automation_account_id" {
  type        = string
  description = "The ID of the Management Account ID"
}

variable "privileged_external_id" {
  type        = string
  description = "Privileged external ID for the meshfed-service to use"
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
