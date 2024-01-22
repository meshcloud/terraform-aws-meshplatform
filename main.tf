data "aws_caller_identity" "management" {
  provider = aws.management
}
data "aws_caller_identity" "meshcloud" {
  provider = aws.meshcloud
}
data "aws_caller_identity" "automation" {
  provider = aws.automation
}

module "meshcloud_account_metering_access" {
  source = "./modules/meshcloud-cost-explorer/ce-meshcloud-account-access"
  providers = {
    aws = aws.meshcloud
  }
  management_account_id                = data.aws_caller_identity.management.account_id
  privileged_external_id               = var.cost_explorer_privileged_external_id
  management_account_service_role_name = var.cost_explorer_management_account_service_role_name
  meshcloud_account_service_user_name  = var.cost_explorer_meshcloud_account_service_user_name
}

module "meshcloud_account_replicator_access" {
  source = "./modules/meshcloud-replicator/replicator-meshcloud-account-access"
  providers = {
    aws = aws.meshcloud
  }
  management_account_id                = data.aws_caller_identity.management.account_id
  automation_account_id                = data.aws_caller_identity.automation.account_id
  privileged_external_id               = var.replicator_privileged_external_id
  meshcloud_account_service_user_name  = var.meshcloud_account_service_user_name
  management_account_service_role_name = var.management_account_service_role_name
  automation_account_service_role_name = var.automation_account_service_role_name
}

module "management_account_metering_access" {
  source = "./modules/meshcloud-cost-explorer/ce-management-account-access"
  providers = {
    aws = aws.management
  }
  meshcloud_account_id                 = data.aws_caller_identity.meshcloud.account_id
  privileged_external_id               = var.cost_explorer_privileged_external_id
  management_account_service_role_name = var.cost_explorer_management_account_service_role_name
  meshcloud_account_service_user_name  = var.cost_explorer_meshcloud_account_service_user_name

  depends_on = [
    module.meshcloud_account_metering_access
  ]
}

module "management_account_replicator_access" {
  source = "./modules/meshcloud-replicator/replicator-management-account-access"
  providers = {
    aws = aws.management
  }
  meshcloud_account_id                 = data.aws_caller_identity.meshcloud.account_id
  privileged_external_id               = var.replicator_privileged_external_id
  support_root_account_via_aws_sso     = var.support_root_account_via_aws_sso
  aws_sso_instance_arn                 = var.aws_sso_instance_arn
  control_tower_enrollment_enabled     = var.control_tower_enrollment_enabled
  control_tower_portfolio_id           = var.control_tower_portfolio_id
  meshcloud_account_service_user_name  = var.meshcloud_account_service_user_name
  management_account_service_role_name = var.management_account_service_role_name
  landing_zone_ou_arns                 = var.landing_zone_ou_arns

  depends_on = [
    module.meshcloud_account_replicator_access
  ]
}

module "automation_account_replicator_access" {
  source = "./modules/meshcloud-replicator/replicator-automation-account-access"
  providers = {
    aws = aws.automation
  }
  meshcloud_account_id                 = data.aws_caller_identity.meshcloud.account_id
  privileged_external_id               = var.replicator_privileged_external_id
  meshcloud_account_service_user_name  = var.meshcloud_account_service_user_name
  automation_account_service_role_name = var.automation_account_service_role_name

  depends_on = [
    module.meshcloud_account_replicator_access
  ]
}
