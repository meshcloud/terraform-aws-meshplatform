data "aws_caller_identity" "management" {
  provider = aws.management
}
data "aws_caller_identity" "meshstack" {
  provider = aws.meshstack
}
data "aws_caller_identity" "automation" {
  provider = aws.automation
}

module "meshstack_account_metering_access" {
  source = "./modules/meshcloud-cost-explorer/ce-meshstack-account-access"
  providers = {
    aws = aws.meshstack
  }
  management_account_id                = data.aws_caller_identity.management.account_id
  privileged_external_id               = var.cost_explorer_privileged_external_id
  management_account_service_role_name = var.cost_explorer_management_account_service_role_name
  meshstack_account_service_user_name  = var.cost_explorer_meshstack_account_service_user_name

  workload_identity_federation = var.workload_identity_federation == null ? null : {
    issuer                = var.workload_identity_federation.issuer,
    audience              = var.workload_identity_federation.audience,
    subject               = var.workload_identity_federation.kraken_subject,
    identity_provider_arn = aws_iam_openid_connect_provider.meshstack[0].arn
  }
}

module "meshstack_account_replicator_access" {
  source = "./modules/meshcloud-replicator/replicator-meshstack-account-access"
  providers = {
    aws = aws.meshstack
  }
  management_account_id                = data.aws_caller_identity.management.account_id
  automation_account_id                = data.aws_caller_identity.automation.account_id
  privileged_external_id               = var.replicator_privileged_external_id
  meshstack_account_service_user_name  = var.meshstack_account_service_user_name
  management_account_service_role_name = var.management_account_service_role_name
  automation_account_service_role_name = var.automation_account_service_role_name

  workload_identity_federation = var.workload_identity_federation == null ? null : {
    issuer                = var.workload_identity_federation.issuer,
    audience              = var.workload_identity_federation.audience,
    subject               = var.workload_identity_federation.replicator_subject,
    identity_provider_arn = aws_iam_openid_connect_provider.meshstack[0].arn
  }
}

module "management_account_metering_access" {
  source = "./modules/meshcloud-cost-explorer/ce-management-account-access"
  providers = {
    aws = aws.management
  }
  meshstack_account_id                 = data.aws_caller_identity.meshstack.account_id
  privileged_external_id               = var.cost_explorer_privileged_external_id
  management_account_service_role_name = var.cost_explorer_management_account_service_role_name
  meshstack_account_service_user_name  = var.cost_explorer_meshstack_account_service_user_name

  allow_federated_role = var.workload_identity_federation != null

  depends_on = [
    module.meshstack_account_metering_access
  ]
}

module "management_account_replicator_access" {
  source = "./modules/meshcloud-replicator/replicator-management-account-access"
  providers = {
    aws = aws.management
  }
  meshstack_account_id                 = data.aws_caller_identity.meshstack.account_id
  privileged_external_id               = var.replicator_privileged_external_id
  support_root_account_via_aws_sso     = var.support_root_account_via_aws_sso
  aws_sso_instance_arn                 = var.aws_sso_instance_arn
  control_tower_enrollment_enabled     = var.control_tower_enrollment_enabled
  control_tower_portfolio_id           = var.control_tower_portfolio_id
  meshstack_account_service_user_name  = var.meshstack_account_service_user_name
  management_account_service_role_name = var.management_account_service_role_name
  landing_zone_ou_arns                 = var.landing_zone_ou_arns

  allow_federated_role = var.workload_identity_federation != null

  depends_on = [
    module.meshstack_account_replicator_access
  ]
}

module "automation_account_replicator_access" {
  source = "./modules/meshcloud-replicator/replicator-automation-account-access"
  providers = {
    aws = aws.automation
  }
  meshstack_account_id                 = data.aws_caller_identity.meshstack.account_id
  privileged_external_id               = var.replicator_privileged_external_id
  meshstack_account_service_user_name  = var.meshstack_account_service_user_name
  automation_account_service_role_name = var.automation_account_service_role_name

  allow_federated_role = var.workload_identity_federation != null

  depends_on = [
    module.meshstack_account_replicator_access
  ]
}
