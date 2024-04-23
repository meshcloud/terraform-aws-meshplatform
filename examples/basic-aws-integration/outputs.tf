output "management_account_id" {
  value       = module.meshplatform.management_account_id
  description = "Management Account ID"
}

output "meshstack_account_id" {
  value       = module.meshplatform.meshstack_account_id
  description = "meshstack account ID"
}

output "automation_account_id" {
  value       = module.meshplatform.automation_account_id
  description = "Automation Account ID"
}

output "replicator_aws_iam_keys" {
  value       = module.meshplatform.replicator_aws_iam_keys
  description = "You can access your credentials when you execute `terraform output replicator_aws_iam_keys` command"
  sensitive   = true
}

output "replicator_management_account_role_arn" {
  description = "Amazon Resource Name (ARN) of Management Account Role for replicator"
  value       = module.meshplatform.replicator_management_account_role_arn
}

output "replicator_automation_account_role_arn" {
  description = "Amazon Resource Name (ARN) of Automation Account Role for replicator"
  value       = module.meshplatform.replicator_automation_account_role_arn
}

output "replicator_privileged_external_id" {
  value       = module.meshplatform.replicator_privileged_external_id
  description = "Replicator privileged_external_id"
  sensitive   = true
}

output "meshstack_access_role_name" {
  value       = module.meshplatform.meshstack_access_role_name
  description = "The name for the Account Access Role that will be rolled out to all managed accounts."
}

output "metering_aws_iam_keys" {
  value       = module.meshplatform.metering_aws_iam_keys
  description = "You can access your credentials when you execute `terraform output metering_aws_iam_keys` command"
  sensitive   = true
}

output "cost_explorer_management_account_role_arn" {
  description = "Amazon Resource Name (ARN) of Management Account Role for replicator"
  value       = module.meshplatform.cost_explorer_management_account_role_arn
}

output "cost_explorer_privileged_external_id" {
  value       = module.meshplatform.cost_explorer_privileged_external_id
  description = "Cost explorer privileged_external_id"
  sensitive   = true
}
