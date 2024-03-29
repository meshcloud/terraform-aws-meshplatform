# It is highly recommended to setup a backend to store the terraform state file
# Removing the backend will output the terraform state in the local filesystem
# See https://www.terraform.io/language/settings/backends for more details
#
# Remove/comment the backend block below if you are only testing the module.
# Please be aware that you cannot destroy the created resources via terraform if you lose the state file.
terraform {
  backend "s3" {
    region  = "eu-west-1"
    profile = "myprofile"
    bucket  = "cloudfoundation-tfstates"
    key     = "meshstack/platforms/aws"
    encrypt = true
  }
}

provider "aws" {
  alias   = "management"
  profile = "management"
}

provider "aws" {
  alias   = "meshcloud"
  profile = "meshcloud"
}

provider "aws" {
  alias   = "automation"
  profile = "automation"
}

module "meshplatform" {
  source = "../../"
  # note: for production use we recommend using a pinned version of the module like so
  # source = "git::https://github.com/meshcloud/terraform-aws-meshplatform.git?ref=v0.2.0"


  providers = {
    aws.management = aws.management
    aws.meshcloud  = aws.meshcloud
    aws.automation = aws.automation
  }

  aws_sso_instance_arn                 = "arn:aws:sso:::instance/ssoins-xxxxxxxxxxxxxxx"
  control_tower_enrollment_enabled     = true
  control_tower_portfolio_id           = "port-xxxxxxxxxxx"
  replicator_privileged_external_id    = "replace with random UUID v4"
  cost_explorer_privileged_external_id = "replace with random UUID v4"
  landing_zone_ou_arns                 = ["arn:aws:organizations::*:ou/o-*/ou-*"]
}
