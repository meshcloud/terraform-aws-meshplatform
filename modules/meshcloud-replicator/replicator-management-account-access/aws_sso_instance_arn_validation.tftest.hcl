mock_provider "aws" {
  mock_data "aws_iam_policy_document" {
    defaults = {
      json = "{\"Version\":\"2012-10-17\",\"Statement\":[]}"
    }
  }

  mock_data "aws_caller_identity" {
    defaults = {
      account_id = "123456789012"
    }
  }

  mock_data "aws_partition" {
    defaults = {
      partition = "aws"
    }
  }

  mock_resource "aws_iam_policy" {
    defaults = {
      arn = "arn:aws:iam::123456789012:policy/MockPolicy"
    }
  }

  mock_resource "aws_iam_role" {
    defaults = {
      arn = "arn:aws:iam::123456789012:role/MockRole"
    }
  }
}

run "valid_sso_instance_arn_passes" {
  command = plan

  variables {
    aws_sso_instance_arn   = "arn:aws:sso:::instance/ssoins-1234567890abcdef0"
    meshcloud_account_id   = "123456789012"
    privileged_external_id = "test-external-id"
  }
}

run "null_sso_instance_arn_passes" {
  command = plan

  variables {
    aws_sso_instance_arn   = null
    meshcloud_account_id   = "123456789012"
    privileged_external_id = "test-external-id"
  }
}

run "invalid_sso_instance_arn_rejected" {
  command = plan

  expect_failures = [var.aws_sso_instance_arn]

  variables {
    aws_sso_instance_arn   = "arn:aws:iam::123456789012:role/SomeRole"
    meshcloud_account_id   = "123456789012"
    privileged_external_id = "test-external-id"
  }
}
