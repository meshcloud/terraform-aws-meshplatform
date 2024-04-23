# Accounts
output "management_account_id" {
  value       = data.aws_caller_identity.management.account_id
  description = "Management Account ID"
}

output "meshstack_account_id" {
  value       = data.aws_caller_identity.meshstack.account_id
  description = "meshstack account ID"
}

output "automation_account_id" {
  value       = data.aws_caller_identity.automation.account_id
  description = "Automation Account ID"
}

# Replicator
output "replicator_aws_iam_keys" {
  value       = module.meshstack_account_replicator_access.aws_iam_keys
  description = "You can access your credentials when you execute `terraform output replicator_aws_iam_keys` command"
  sensitive   = true
}

output "replicator_management_account_role_arn" {
  description = "Amazon Resource Name (ARN) of Management Account Role for replicator"
  value       = module.management_account_replicator_access.management_account_role_arn
}

output "replicator_automation_account_role_arn" {
  description = "Amazon Resource Name (ARN) of Automation Account Role for replicator"
  value       = module.automation_account_replicator_access.automation_account_role_arn
}

output "replicator_privileged_external_id" {
  value       = var.replicator_privileged_external_id
  description = "Replicator privileged_external_id"
  sensitive   = true
}

output "replicator_workload_identity_federation_role" {
  value = var.workload_identity_federation == null ? null : module.meshstack_account_replicator_access.workload_identity_federation_role
}

output "meshstack_access_role_name" {
  description = "The name for the Account Access Role that will be rolled out to all managed accounts."
  value       = module.management_account_replicator_access.meshstack_access_role_name
}

# Metering
output "metering_aws_iam_keys" {
  value       = module.meshstack_account_metering_access.aws_iam_keys
  description = "You can access your credentials when you execute `terraform output metering_aws_iam_keys` command"
  sensitive   = true
}

output "cost_explorer_management_account_role_arn" {
  description = "Amazon Resource Name (ARN) of Management Account Role for replicator"
  value       = module.management_account_metering_access.management_account_role_arn
}

output "cost_explorer_privileged_external_id" {
  value       = var.cost_explorer_privileged_external_id
  description = "Cost explorer privileged_external_id"
  sensitive   = true
}

output "cost_explorer_identity_federation_role" {
  value = var.workload_identity_federation == null ? null : module.meshstack_account_metering_access.workload_identity_federation_role
}
