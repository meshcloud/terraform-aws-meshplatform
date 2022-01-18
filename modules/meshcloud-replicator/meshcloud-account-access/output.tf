output "aws_iam_keys" {
  value = {
    aws_access_key = aws_iam_access_key.meshfed_service.id
    aws_secret_key = aws_iam_access_key.meshfed_service.secret
  }
}
