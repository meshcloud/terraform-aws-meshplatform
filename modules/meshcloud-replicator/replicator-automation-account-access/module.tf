# Automation Account Setup
resource "aws_iam_role" "meshfed_automation" {
  name               = var.automation_account_service_role_name
  description        = "This role is assumed by ${var.meshcloud_account_service_user_name} to administer CloudFormation."
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

# SSA stands for StackSetAdministration; reduced because of AWS role name limit (64)
resource "aws_iam_role" "cloudformation_stackset_admin" {
  name               = "${var.automation_account_service_role_name}-AWSCloudFormationSSARole"
  description        = ""
  assume_role_policy = data.aws_iam_policy_document.cloudformation_admin_assume_role.json
}

# SSE stands for StackSetExecution; reduced because of AWS policy name limit (128)
resource "aws_iam_policy" "cloudformation_stackset_execution" {
  name   = "${var.automation_account_service_role_name}-AssumeSSERolePolicy"
  policy = data.aws_iam_policy_document.cloudformation_stackset_execution.json
}

resource "aws_iam_role_policy_attachment" "cloudformation_stackset" {
  role       = aws_iam_role.cloudformation_stackset_admin.name
  policy_arn = aws_iam_policy.cloudformation_stackset_execution.arn
}
