variable "management_account_service_role_name" {
  type    = string
  default = "MeshCostExplorerServiceRole"
}

variable "meshcloud_account_service_user_name" {
  type    = string
  default = "meshcloud-cost-explorer-user"
}

variable "meshcloud_account_id" {
  type        = string
  description = "The ID of the meshCloud AWS Account"
}

variable "privileged_external_id" {
  type        = string
  description = "Privileged external ID for the meshfed-service to use"
}
