output "management_account_role_arn" {
  description = "Amazon Resource Name (ARN) of Management Account Role"
  value       = aws_iam_role.meshfed_service.arn
}

output "meshstack_access_role_name" {
  description = "The name for the Account Access Role that will be rolled out to all managed accounts."
  value       = var.meshstack_access_role_name
}
