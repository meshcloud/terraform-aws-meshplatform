variable "meshcloud_account_service_user_name" {
  type    = string
  default = "meshfed-service-user"
}

variable "management_account_service_role_name" {
  type    = string
  default = "MeshfedServiceRole"
}

variable "management_account_id" {
  type        = string
  description = "The ID of the Management Account ID"
}

variable "automation_account_service_role_name" {
  type    = string
  default = "MeshfedAutomationRole"
}

variable "automation_account_id" {
  type        = string
  description = "The ID of the Management Account ID"
}

variable "privileged_external_id" {
  type        = string
  description = "Privileged external ID for the meshfed-service to use"
}
