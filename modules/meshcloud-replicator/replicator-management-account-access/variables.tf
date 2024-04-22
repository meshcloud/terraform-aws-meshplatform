variable "management_account_service_role_name" {
  type        = string
  default     = "MeshfedServiceRole"
  description = "Name of the custom role in the management account. See https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform-aws-manually.html#set-up-aws-account-2-management"
}

variable "meshcloud_account_service_user_name" {
  type        = string
  default     = "meshfed-service-user"
  description = "Name of the meshfed-service user. This user is responsible for replication."
}

variable "meshstack_access_role_name" {
  type        = string
  default     = "MeshstackAccountAccessRole"
  description = "Account access role used by meshfed-service."
}

variable "meshcloud_account_id" {
  type        = string
  description = "The ID of the meshcloud AWS Account"
}

variable "privileged_external_id" {
  type        = string
  description = "Privileged external ID for the meshfed-service to use"
}

variable "control_tower_enrollment_enabled" {
  type        = bool
  description = "Set to true, to allow meshStack to enroll Accounts via AWS Control Tower for the meshPlatform"
  default     = false
}

variable "control_tower_portfolio_id" {
  type        = string
  default     = ""
  description = "Must be set for AWS Control Tower"
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
  default     = []
}

variable "can_close_accounts_in_resource_org_paths" {
  type = list(string)
  // see https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html#condition-keys-resourceorgpaths
  description = "AWS ResourceOrgPaths that are used in Landing Zones and where meshStack is allowed to close accounts."
  default     = [] // example: o-a1b2c3d4e5/r-f6g7h8i9j0example/ou-ghi0-awsccccc/ou-jkl0-awsddddd/
}

variable "allow_federated_role" {
  type    = bool
  default = false
}
