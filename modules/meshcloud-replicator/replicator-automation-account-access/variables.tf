variable "meshstack_account_service_user_name" {
  type        = string
  default     = "meshfed-service-user"
  description = "Name of the meshfed-service user. This user is responsible for replication."
}

variable "meshstack_account_id" {
  type        = string
  description = "The ID of the meshcloud AWS Account."
}

variable "privileged_external_id" {
  type        = string
  description = "Privileged external ID for the meshfed-service to use."
}

variable "automation_account_service_role_name" {
  type        = string
  default     = "MeshfedAutomationRole"
  description = "Name of the custom role in the automation account. See https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform-aws-manually.html#set-up-aws-account-3-automation"
}

variable "allow_federated_role" {
  type    = bool
  default = false
}
