output "aws_iam_keys" {
  value = {
    aws_access_key = aws_iam_access_key.meshcloud_cost_explorer.id
    aws_secret_key = aws_iam_access_key.meshcloud_cost_explorer.secret
  }
}
