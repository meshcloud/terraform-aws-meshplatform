## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.automation"></a> [aws.automation](#provider\_aws.automation) | >= 2.7.0 |
| <a name="provider_aws.management"></a> [aws.management](#provider\_aws.management) | >= 2.7.0 |
| <a name="provider_aws.meshcloud"></a> [aws.meshcloud](#provider\_aws.meshcloud) | >= 2.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_automation_account_replicator_access"></a> [automation\_account\_replicator\_access](#module\_automation\_account\_replicator\_access) | ./modules/meshcloud-replicator/automation-account-access | n/a |
| <a name="module_management_account_kraken_access"></a> [management\_account\_kraken\_access](#module\_management\_account\_kraken\_access) | ./modules/meshcloud-cost-explorer/management-account-access | n/a |
| <a name="module_management_account_replicator_access"></a> [management\_account\_replicator\_access](#module\_management\_account\_replicator\_access) | ./modules/meshcloud-replicator/management-account-access | n/a |
| <a name="module_meshcloud_account_kraken_access"></a> [meshcloud\_account\_kraken\_access](#module\_meshcloud\_account\_kraken\_access) | ./modules/meshcloud-cost-explorer/meshcloud-account-access | n/a |
| <a name="module_meshcloud_account_replicator_access"></a> [meshcloud\_account\_replicator\_access](#module\_meshcloud\_account\_replicator\_access) | ./modules/meshcloud-replicator/meshcloud-account-access | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.automation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.meshcloud](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automation_account_service_role_name"></a> [automation\_account\_service\_role\_name](#input\_automation\_account\_service\_role\_name) | Name of the custom role in the automation account. See https://docs.meshcloud.io/docs/meshstack.aws.index.html#automation-account-setup | `string` | `"MeshfedAutomationRole"` | no |
| <a name="input_automation_profile"></a> [automation\_profile](#input\_automation\_profile) | AWS Account profile for automation AWS account. | `string` | `"automation"` | no |
| <a name="input_aws_enrollment_enabled"></a> [aws\_enrollment\_enabled](#input\_aws\_enrollment\_enabled) | Set to true, to allow meshStack to enroll Accounts via AWS Control Tower for the meshPlatform. | `bool` | `false` | no |
| <a name="input_aws_sso_instance_arn"></a> [aws\_sso\_instance\_arn](#input\_aws\_sso\_instance\_arn) | AWS SSO Instance ARN. Needs to be of the form arn:aws:sso:::instance/ssoins-xxxxxxxxxxxxxxx. Setup instructions https://docs.meshcloud.io/docs/meshstack.aws.sso-setup.html. | `string` | n/a | yes |
| <a name="input_cost_explorer_management_account_service_role_name"></a> [cost\_explorer\_management\_account\_service\_role\_name](#input\_cost\_explorer\_management\_account\_service\_role\_name) | Name of the custom role in the management account used by the cost explorer user. | `string` | `"MeshCostExplorerServiceRole"` | no |
| <a name="input_cost_explorer_meshcloud_account_service_user_name"></a> [cost\_explorer\_meshcloud\_account\_service\_user\_name](#input\_cost\_explorer\_meshcloud\_account\_service\_user\_name) | Name of the user using cost explorer service to collect metering data. | `string` | `"meshcloud-cost-explorer-user"` | no |
| <a name="input_cost_explorer_privileged_external_id"></a> [cost\_explorer\_privileged\_external\_id](#input\_cost\_explorer\_privileged\_external\_id) | Set this variable to a random UUID version 4. The external id is a secondary key to make an AssumeRole API call. | `string` | n/a | yes |
| <a name="input_landing_zone_ou_arns"></a> [landing\_zone\_ou\_arns](#input\_landing\_zone\_ou\_arns) | Organizational Unit ARNs that are used in Landing Zones. We recommend to explicitly list the OU ARNs that meshStack should manage. | `list(string)` | <pre>[<br>  "arn:aws:organizations::*:ou/o-*/ou-*"<br>]</pre> | no |
| <a name="input_management_account_service_role_name"></a> [management\_account\_service\_role\_name](#input\_management\_account\_service\_role\_name) | Name of the custom role in the management account. See https://docs.meshcloud.io/docs/meshstack.aws.index.html#aws-management-account-setup | `string` | `"MeshfedServiceRole"` | no |
| <a name="input_management_profile"></a> [management\_profile](#input\_management\_profile) | AWS Account profile for management AWS account. | `string` | `"management"` | no |
| <a name="input_meshcloud_account_service_user_name"></a> [meshcloud\_account\_service\_user\_name](#input\_meshcloud\_account\_service\_user\_name) | Name of the user for accessing meshcloud account. | `string` | `"meshfed-service-user"` | no |
| <a name="input_meshcloud_profile"></a> [meshcloud\_profile](#input\_meshcloud\_profile) | AWS Account profile for meshcloud AWS account. | `string` | `"meshcloud"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region of the three AWS accounts needed for the meshPlatform. | `string` | `"eu-central-1"` | no |
| <a name="input_replicator_privileged_external_id"></a> [replicator\_privileged\_external\_id](#input\_replicator\_privileged\_external\_id) | Set this variable to a random UUID version 4. The external id is a secondary key to make an AssumeRole API call. | `string` | n/a | yes |
| <a name="input_support_root_account_via_aws_sso"></a> [support\_root\_account\_via\_aws\_sso](#input\_support\_root\_account\_via\_aws\_sso) | Set to true to allow meshStack to manage the Organization's AWS Root account's access via AWS SSO. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_automation_account_id"></a> [automation\_account\_id](#output\_automation\_account\_id) | Automation Account ID |
| <a name="output_cost_explorer_privileged_external_id"></a> [cost\_explorer\_privileged\_external\_id](#output\_cost\_explorer\_privileged\_external\_id) | Cost explorer privileged\_external\_id |
| <a name="output_kraken_aws_iam_keys"></a> [kraken\_aws\_iam\_keys](#output\_kraken\_aws\_iam\_keys) | You can access your credentials when you execute `terraform output kraken_aws_iam_keys` command |
| <a name="output_management_account_id"></a> [management\_account\_id](#output\_management\_account\_id) | Management Account ID |
| <a name="output_meshcloud_account_id"></a> [meshcloud\_account\_id](#output\_meshcloud\_account\_id) | Meshcloud Account ID |
| <a name="output_replicator_aws_iam_keys"></a> [replicator\_aws\_iam\_keys](#output\_replicator\_aws\_iam\_keys) | You can access your credentials when you execute `terraform output replicator_aws_iam_keys` command |
| <a name="output_replicator_privileged_external_id"></a> [replicator\_privileged\_external\_id](#output\_replicator\_privileged\_external\_id) | Replicator privileged\_external\_id |
