# Automation Account Setup
resource "aws_iam_role" "meshfed_automation" {
  name               = var.automation_account_service_role_name
  description        = "This role is assumed by ${var.meshcloud_account_service_user_name} to invoke Lambda functions."
  assume_role_policy = data.aws_iam_policy_document.meshfed_automation_assume_role.json
}

resource "aws_iam_policy" "meshfed_automation" {
  name   = "${var.automation_account_service_role_name}AutomationPolicy"
  policy = data.aws_iam_policy_document.meshfed_automation.json
}

resource "aws_iam_role_policy_attachment" "meshfed_automation" {
  role       = aws_iam_role.meshfed_automation.name
  policy_arn = aws_iam_policy.meshfed_automation.arn
}
