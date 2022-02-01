variable "management_account_service_role_name" {
  type    = string
  default = "MeshfedServiceRole"
}

variable "meshcloud_account_service_user_name" {
  type    = string
  default = "meshfed-service-user"
}

variable "meshstack_access_role_name" {
  type    = string
  default = "MeshstackAccountAccessRole"
}

variable "meshcloud_account_id" {
  type        = string
  description = "The ID of the meshCloud AWS Account"
}

variable "privileged_external_id" {
  type        = string
  description = "Privileged external ID for the meshfed-service to use"
}

variable "aws_enrollment_enabled" {
  type        = bool
  description = "Set to true, to allow meshStack to enroll Accounts via AWS Control Tower for the meshPlatform"
  default     = false
}

variable "aws_sso_instance_arn" {
  type        = string
  description = "ARN of the AWS SSO instance to use"
}

variable "support_root_account_via_aws_sso" {
  type        = bool
  description = "Set to true to allow meshStack to manage the Organization's AWS Root account's access via AWS SSO"
  default     = false
}

variable "landing_zone_ou_arns" {
  type        = list(string)
  description = "Organizational Unit ARNs that are used in Landing Zones. We recommend to explicitly list the OU ARNs that meshStack should manage."
  default = [
    "arn:aws:organizations::*:ou/o-*/ou-*"
  ]
}
