# in case of workload identity federation we must add the appropriate identity provider
resource "aws_iam_openid_connect_provider" "meshstack" {
  provider = aws.meshstack
  count    = var.workload_identity_federation != null ? 1 : 0

  url             = var.workload_identity_federation.issuer
  client_id_list  = [var.workload_identity_federation.audience]
  thumbprint_list = [var.workload_identity_federation.thumbprint]
}
