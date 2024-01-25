# AWS Root Account Setup
resource "aws_iam_role" "meshfed_service" {
  name               = var.management_account_service_role_name
  description        = "This role is used by ${var.meshcloud_account_service_user_name} to obtain permissions on an org-wide level"
  assume_role_policy = data.aws_iam_policy_document.meshfed_service_assume_role.json
}

resource "aws_iam_policy" "meshfed_service" {
  name   = "${var.management_account_service_role_name}Policy"
  policy = data.aws_iam_policy_document.meshfed_service.json
}

resource "aws_iam_role_policy_attachment" "meshfed_service" {
  role       = aws_iam_role.meshfed_service.name
  policy_arn = aws_iam_policy.meshfed_service.arn
}

resource "aws_iam_role_policy_attachment" "meshfed_service_enrollment_sc_enduser" {
  count      = var.control_tower_enrollment_enabled ? 1 : 0
  role       = aws_iam_role.meshfed_service.name
  policy_arn = "arn:aws:iam::aws:policy/AWSServiceCatalogEndUserFullAccess"
}

resource "aws_iam_role_policy_attachment" "meshfed_service_enrollment_sc_adm_read" {
  count      = var.control_tower_enrollment_enabled ? 1 : 0
  role       = aws_iam_role.meshfed_service.name
  policy_arn = "arn:aws:iam::aws:policy/AWSServiceCatalogAdminReadOnlyAccess"
}

resource "aws_iam_policy" "meshfed_service_enrollment_additional" {
  count  = var.control_tower_enrollment_enabled ? 1 : 0
  name   = "${var.management_account_service_role_name}AdditionalPolicy"
  policy = data.aws_iam_policy_document.meshfed_service_enrollment_additional.json
}

resource "aws_iam_role_policy_attachment" "meshfed_service_enrollment_additional" {
  count      = var.control_tower_enrollment_enabled ? 1 : 0
  role       = aws_iam_role.meshfed_service.name
  policy_arn = aws_iam_policy.meshfed_service_enrollment_additional[0].arn
}

resource "aws_servicecatalog_principal_portfolio_association" "meshfed_service" {
  count         = var.control_tower_enrollment_enabled ? 1 : 0
  portfolio_id  = var.control_tower_portfolio_id
  principal_arn = aws_iam_role.meshfed_service.arn
}
