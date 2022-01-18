provider "aws" {
  version = "=2.49"
  region  = var.region
}

# This provider is needed to apply meshfed-service role to the "meshcloud account"
provider "aws" {
  alias = "meshcloud"
  assume_role {
    role_arn    = "arn:aws:iam::${var.meshcloud_account_id}:role/MeshstackAccountAccessRole"
    external_id = var.privileged_external_id
  }
  region = var.region
}
