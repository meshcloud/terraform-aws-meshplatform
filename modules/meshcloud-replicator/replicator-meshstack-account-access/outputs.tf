output "aws_iam_keys" {
  description = "AWS access and secret keys for meshfed-service user."
  value = var.create_access_key ? {
    aws_access_key = aws_iam_access_key.meshfed_service[0].id
    aws_secret_key = aws_iam_access_key.meshfed_service[0].secret
  } : null
  sensitive = true
}

output "workload_identity_federation_role" {
  value = var.workload_identity_federation == null ? null : aws_iam_role.assume_meshfed_service_role[0].arn
}
