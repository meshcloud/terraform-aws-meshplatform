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
| [aws_iam_access_key.meshcloud_cost_explorer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_policy.meshcloud_cost_explorer_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.meshcloud_cost_explorer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.meshcloud_cost_explorer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.meshcloud_cost_explorer_user_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_management_account_id"></a> [management\_account\_id](#input\_management\_account\_id) | The ID of the Management Account ID | `string` | n/a | yes |
| <a name="input_management_account_service_role_name"></a> [management\_account\_service\_role\_name](#input\_management\_account\_service\_role\_name) | n/a | `string` | `"MeshCostExplorerServiceRole"` | no |
| <a name="input_meshcloud_account_service_user_name"></a> [meshcloud\_account\_service\_user\_name](#input\_meshcloud\_account\_service\_user\_name) | n/a | `string` | `"meshcloud-cost-explorer-user"` | no |
| <a name="input_privileged_external_id"></a> [privileged\_external\_id](#input\_privileged\_external\_id) | Privileged external ID for the cost-explorer-service to use | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_iam_keys"></a> [aws\_iam\_keys](#output\_aws\_iam\_keys) | n/a |
