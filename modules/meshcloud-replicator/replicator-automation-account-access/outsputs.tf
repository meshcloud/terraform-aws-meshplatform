output "automation_account_role_arn" {
  description = "Amazon Resource Name (ARN) of Automation Account Role"
  value = aws_iam_role.meshfed_automation.arn
}
