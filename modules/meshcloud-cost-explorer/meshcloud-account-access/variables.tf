variable "management_account_service_role_name" {
  type    = string
  default = "MeshCostExplorerServiceRole"
}

variable "meshcloud_account_service_user_name" {
  type    = string
  default = "meshcloud-cost-explorer-user"
}

variable "management_account_id" {
  type        = string
  description = "The ID of the Management Account ID"
}

variable "privileged_external_id" {
  type        = string
  description = "Privileged external ID for the cost-explorer-service to use"
}
