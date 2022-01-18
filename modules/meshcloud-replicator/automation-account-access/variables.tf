variable "meshcloud_account_service_user_name" {
  type = string
}

variable "meshcloud_account_id" {
  type        = string
  description = "The ID of the meshCloud AWS Account"
}

variable "privileged_external_id" {
  type        = string
  description = "Privileged external ID for the meshfed-service to use"
}

variable "automation_account_service_role_name" {
  type    = string
  default = "MeshfedAutomationRole"
}