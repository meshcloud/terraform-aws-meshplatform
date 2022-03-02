variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "AWS region of the three AWS accounts needed for the meshPlatform."
}

variable "aws_sso_instance_arn" {
  type        = string
  description = "AWS SSO Instance ARN. Needs to be of the form arn:aws:sso:::instance/ssoins-xxxxxxxxxxxxxxx. Setup instructions https://docs.meshcloud.io/docs/meshstack.aws.sso-setup.html."
}

variable "aws_enrollment_enabled" {
  type        = bool
  default     = false
  description = "Set to true, to allow meshStack to enroll Accounts via AWS Control Tower for the meshPlatform."
}

variable "replicator_privileged_external_id" {
  type        = string
  description = "Set this variable to a random UUID version 4. The external id is a secondary key to make an AssumeRole API call."
  # validation {
  #   condition     = can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12}$", var.replicator_privileged_external_id))
  #   error_message = "Must be a valid UUID version 4."
  # }
}

variable "cost_explorer_privileged_external_id" {
  type        = string
  description = "Set this variable to a random UUID version 4. The external id is a secondary key to make an AssumeRole API call."
  # validation {
  #   condition     = can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12}$", var.cost_explorer_privileged_external_id))
  #   error_message = "Must be a valid UUID version 4."
  # }
}

variable "landing_zone_ou_arns" {
  type        = list(string)
  description = "Organizational Unit ARNs that are used in Landing Zones. We recommend to explicitly list the OU ARNs that meshStack should manage."
  default     = ["arn:aws:organizations::*:ou/o-*/ou-*"]
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "management_profile" {
  type        = string
  default     = "management"
  description = "AWS Account profile for management AWS account."
}

variable "meshcloud_profile" {
  type        = string
  default     = "meshcloud"
  description = "AWS Account profile for meshcloud AWS account."
}

variable "automation_profile" {
  type        = string
  default     = "automation"
  description = "AWS Account profile for automation AWS account."
}

variable "meshcloud_account_service_user_name" {
  type        = string
  default     = "meshfed-service-user"
  description = "Name of the user for accessing meshcloud account."
}

variable "management_account_service_role_name" {
  type        = string
  default     = "MeshfedServiceRole"
  description = "Name of the custom role in the management account. See https://docs.meshcloud.io/docs/meshstack.aws.index.html#aws-management-account-setup"
}

variable "automation_account_service_role_name" {
  type        = string
  default     = "MeshfedAutomationRole"
  description = "Name of the custom role in the automation account. See https://docs.meshcloud.io/docs/meshstack.aws.index.html#automation-account-setup"
}

variable "cost_explorer_management_account_service_role_name" {
  type        = string
  default     = "MeshCostExplorerServiceRole"
  description = "Name of the custom role in the management account used by the cost explorer user."
}

variable "cost_explorer_meshcloud_account_service_user_name" {
  type        = string
  default     = "meshcloud-cost-explorer-user"
  description = "Name of the user using cost explorer service to collect metering data."
}

variable "support_root_account_via_aws_sso" {
  type        = bool
  default     = false
  description = "Set to true to allow meshStack to manage the Organization's AWS Root account's access via AWS SSO."
}
