output "management_account_role_arn" {
  description = "Amazon Resource Name (ARN) of Management Account Role"
  value       = aws_iam_role.cost_explorer_service.arn
}
