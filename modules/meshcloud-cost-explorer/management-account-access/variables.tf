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

variable "meshcloud_account_id" {
  type        = string
  description = "The ID of the meshcloud AWS Account."
}

variable "privileged_external_id" {
  type        = string
  description = "Privileged external ID for the meshfed-service to use"
}
