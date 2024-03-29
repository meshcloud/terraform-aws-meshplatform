<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.meshfed_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_policy.meshfed_service_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.assume_meshfed_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.meshfed_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.meshfed_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.meshfed_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.meshfed_service_user_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.workload_identity_federation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automation_account_id"></a> [automation\_account\_id](#input\_automation\_account\_id) | The ID of the Management Account ID | `string` | n/a | yes |
| <a name="input_automation_account_service_role_name"></a> [automation\_account\_service\_role\_name](#input\_automation\_account\_service\_role\_name) | Name of the custom role in the automation account. See https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform-aws-manually.html#set-up-aws-account-3-automation | `string` | `"MeshfedAutomationRole"` | no |
| <a name="input_create_access_key"></a> [create\_access\_key](#input\_create\_access\_key) | Create access key for service account | `bool` | `true` | no |
| <a name="input_management_account_id"></a> [management\_account\_id](#input\_management\_account\_id) | The ID of the Management Account ID | `string` | n/a | yes |
| <a name="input_management_account_service_role_name"></a> [management\_account\_service\_role\_name](#input\_management\_account\_service\_role\_name) | Name of the custom role in the management account. See https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform-aws-manually.html#set-up-aws-account-2-management | `string` | `"MeshfedServiceRole"` | no |
| <a name="input_meshcloud_account_service_user_name"></a> [meshcloud\_account\_service\_user\_name](#input\_meshcloud\_account\_service\_user\_name) | Name of the meshfed-service user. This user is responsible for replication. | `string` | `"meshfed-service-user"` | no |
| <a name="input_privileged_external_id"></a> [privileged\_external\_id](#input\_privileged\_external\_id) | Privileged external ID for the meshfed-service to use | `string` | n/a | yes |
| <a name="input_workload_identity_federation"></a> [workload\_identity\_federation](#input\_workload\_identity\_federation) | n/a | <pre>object({<br>    issuer                = string,<br>    audience              = string,<br>    subject               = string,<br>    identity_provider_arn = string<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_iam_keys"></a> [aws\_iam\_keys](#output\_aws\_iam\_keys) | AWS access and secret keys for meshfed-service user. |
| <a name="output_workload_identity_federation_role"></a> [workload\_identity\_federation\_role](#output\_workload\_identity\_federation\_role) | n/a |
<!-- END_TF_DOCS -->