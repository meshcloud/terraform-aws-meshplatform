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
| [aws_iam_policy.meshfed_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.meshfed_service_enrollment_additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.meshfed_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.meshfed_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.meshfed_service_enrollment_additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.meshfed_service_enrollment_sc_adm_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.meshfed_service_enrollment_sc_enduser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_servicecatalog_principal_portfolio_association.meshfed_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicecatalog_principal_portfolio_association) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.meshfed_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.meshfed_service_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.meshfed_service_enrollment_additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_sso_instance_arn"></a> [aws\_sso\_instance\_arn](#input\_aws\_sso\_instance\_arn) | ARN of the AWS SSO instance to use | `string` | n/a | yes |
| <a name="input_control_tower_enrollment_enabled"></a> [control\_tower\_enrollment\_enabled](#input\_control\_tower\_enrollment\_enabled) | Set to true, to allow meshStack to enroll Accounts via AWS Control Tower for the meshPlatform | `bool` | `false` | no |
| <a name="input_control_tower_portfolio_id"></a> [control\_tower\_portfolio\_id](#input\_control\_tower\_portfolio\_id) | Must be set for AWS Control Tower | `string` | `""` | no |
| <a name="input_landing_zone_ou_arns"></a> [landing\_zone\_ou\_arns](#input\_landing\_zone\_ou\_arns) | Organizational Unit ARNs that are used in Landing Zones. We recommend to explicitly list the OU ARNs that meshStack should manage. | `list(string)` | <pre>[<br>  "arn:aws:organizations::*:ou/o-*/ou-*"<br>]</pre> | no |
| <a name="input_management_account_service_role_name"></a> [management\_account\_service\_role\_name](#input\_management\_account\_service\_role\_name) | Name of the custom role in the management account. See https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform-aws-manually.html#set-up-aws-account-2-management | `string` | `"MeshfedServiceRole"` | no |
| <a name="input_meshcloud_account_id"></a> [meshcloud\_account\_id](#input\_meshcloud\_account\_id) | The ID of the meshcloud AWS Account | `string` | n/a | yes |
| <a name="input_meshcloud_account_service_user_name"></a> [meshcloud\_account\_service\_user\_name](#input\_meshcloud\_account\_service\_user\_name) | Name of the meshfed-service user. This user is responsible for replication. | `string` | `"meshfed-service-user"` | no |
| <a name="input_meshstack_access_role_name"></a> [meshstack\_access\_role\_name](#input\_meshstack\_access\_role\_name) | Account access role used by meshfed-service. | `string` | `"MeshstackAccountAccessRole"` | no |
| <a name="input_privileged_external_id"></a> [privileged\_external\_id](#input\_privileged\_external\_id) | Privileged external ID for the meshfed-service to use | `string` | n/a | yes |
| <a name="input_support_root_account_via_aws_sso"></a> [support\_root\_account\_via\_aws\_sso](#input\_support\_root\_account\_via\_aws\_sso) | Set to true to allow meshStack to manage the Organization's AWS Root account's access via AWS SSO | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_management_account_role_arn"></a> [management\_account\_role\_arn](#output\_management\_account\_role\_arn) | Amazon Resource Name (ARN) of Management Account Role |
| <a name="output_meshstack_access_role_name"></a> [meshstack\_access\_role\_name](#output\_meshstack\_access\_role\_name) | The name for the Account Access Role that will be rolled out to all managed accounts. |
<!-- END_TF_DOCS -->