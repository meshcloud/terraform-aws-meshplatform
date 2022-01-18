resource "aws_iam_user" "cost_usage_report" {
  name = var.iam_user_name
}

resource "aws_iam_access_key" "cost_usage_report" {
  user = aws_iam_user.cost_usage_report.name
}

resource "aws_iam_policy" "bucket_access" {
  name        = "${var.iam_user_name}-bucket-access"
  description = "This policy allows the '${aws_iam_user.cost_usage_report.name}' iam user to fetch AWS usage reports"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "${data.aws_s3_bucket.selected.arn}",
                "${data.aws_s3_bucket.selected.arn}/*"
            ]
        }
    ]
}
  EOF
}

resource "aws_iam_policy" "org_access" {
  name        = "${var.iam_user_name}-org-access"
  description = "This policy allows the '${aws_iam_user.cost_usage_report.name}' to list all accounts in the organization"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "organizations:ListAccounts",
            "Resource": "*"
        }
    ]
}
  EOF
}

resource "aws_iam_policy" "assume_role" {
  name        = "${aws_iam_user.cost_usage_report.name}-sts-assume-role"
  description = "This policy allows ${aws_iam_user.cost_usage_report.name} to assume the IAM Role '${aws_iam_role.role.name}'"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "${aws_iam_role.role.arn}"
        }
    ]
}
  EOF
}

# This role allows listing all accounts in the Organization
# A trust policy allows the aws_iam_user to assume this role
resource "aws_iam_role" "role" {
  name               = "${aws_iam_user.cost_usage_report.name}Role"
  description        = "This role is used by ${aws_iam_user.cost_usage_report.name} to obtain permissions on an org-wide level"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.cost_usage_report.arn}"
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "bucket_access" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.bucket_access.arn
}

resource "aws_iam_role_policy_attachment" "org_access" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.org_access.arn
}

resource "aws_iam_user_policy_attachment" "assume_role" {
  user       = aws_iam_user.cost_usage_report.name
  policy_arn = aws_iam_policy.assume_role.arn
}

