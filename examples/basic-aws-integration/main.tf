# It is highly recommended to setup a backend to store the terraform state file
# Removing the backend will output the terraform state in the local filesystem
# See https://www.terraform.io/language/settings/backends for more details
#
# Remove/comment the backend block below if you are only testing the module.
# Please be aware that you cannot destroy the created resources via terraform if you lose the state file.
terraform {
  backend "gcs" {
    prefix = "meshplatforms/aws"
    bucket = "my-terraform-states"
  }
}

module "meshplatform" {
  source = "git::https://github.com/meshcloud/terraform-aws-meshplatform.git"

  aws_sso_instance_arn                 = "arn:aws:sso:::instance/ssoins-xxxxxxxxxxxxxxx"
  aws_enrollment_enabled               = true
  replicator_privileged_external_id    = "replace with random UUID v4"
  cost_explorer_privileged_external_id = "replace with random UUID v4"
}