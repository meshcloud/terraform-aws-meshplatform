# AWS meshPlatform Module

meshStack is a Cloud Foundation Platform by meshcloud. AWS is a proprietary public cloud platform provided by Amazon Web Services. meshStack supports project and user management for AWS to include AWS services into cloud projects managed by meshStack.

This terraform module is used to integrate AWS into a meshStack instance as a meshPlatform. More information on the integration can be found on [meshcloud public docs](https://docs.meshcloud.io/docs/meshstack.aws.index.html).

## Prerequisites

You need this policy to execute necessary actions on your Terraform providers.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:Get*",
                "iam:List*",
                "iam:UpdateAssumeRolePolicy",
                "iam:DeleteAccessKey",
                "iam:UntagRole",
                "iam:TagRole",
                "iam:DeletePolicy",
                "iam:CreateRole",
                "iam:AttachRolePolicy",
                "iam:PutRolePolicy",
                "iam:CreateUser",
                "iam:CreateAccessKey",
                "iam:DetachRolePolicy",
                "iam:DeleteRolePolicy",
                "iam:DetachUserPolicy",
                "iam:CreatePolicyVersion",
                "iam:ListAccessKeys",
                "iam:DeleteUserPolicy",
                "iam:AttachUserPolicy",
                "iam:DeleteRole",
                "iam:UpdateAccessKey",
                "iam:DeleteUser",
                "iam:TagPolicy",
                "iam:TagUser",
                "iam:CreatePolicy",
                "iam:UntagUser",
                "iam:PutUserPolicy",
                "iam:UntagPolicy",
                "iam:DeletePolicyVersion"
            ],
            "Resource": "*"
        }
    ]
}
```

## How to use this Module

1. Login into your AWS Management Account (Root Organization).

    Ensure your organization account user has `IAMFullPermissions`,  `AmazonS3FullAccess` and `AWSOrganizationsFullAccess` permissions.

2. Open your Organization and create two new AWS accounts.

    2.1 Create the `meshcloud` account. The meshStack will use this account to manage AWS accounts in your organization.

    2.2 Create the `automation` account. The meshStack will use this account to manage CloudFormation that are used in [Landing Zones](https://docs.meshcloud.io/docs/meshcloud.landing-zones.html).

3. Prepare permissions for executing the meshPlatform AWS Module.

    3.1 Login into the new `meshcloud` account. Create a new IAM user and create AccessKey-SecretKey which has `IAMFullPermissions` and save the credentials.

    3.2 Login into the new `automation` account. Create a new IAM user and create AccessKey-SecretKey which has `IAMFullPermissions` and save the credentials.

    3.3 Login into the `management` account. Create a new IAM user and create AccessKey-SecretKey which has `IAMFullPermissions` and save the credentials.

4. Open AWS CloudShell Service on your Root management account.[^1]

    4.1 Install terraform into Cloudshell.

    ```sh
    # Terminal Commands For Amazon Linux
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum -y install terraform
    ```

    4.2 Configure credentials for aws CLI.

    ```sh
    cat > ~/.aws/credentials << EOF
    [management]
    aws_access_key_id = XXXX
    aws_secret_access_key = XXXX
    [meshcloud]
    aws_access_key_id = XXXX
    aws_secret_access_key = XXXX
    [automation]
    aws_access_key_id = XXXX
    aws_secret_access_key = XXXX
    EOF
    ```

5. Clone the repository and navigate into it.

    ```sh
    git clone https://github.com/meshcloud/terraform-aws-meshplatform.git
    cd terraform-aws-meshplatform
    ```

6. Create a `terraform.tfvars` file and fill in the variables defined in `variables.tf`.[^2]

    ```sh
    cat > ~/terraform-aws-meshplatform/terraform.tfvars << EOF
    aws_sso_instance_arn = "arn:aws:sso:::instance/ssoins-xxxxxxxxxxxxxxx"
    aws_enrollment_enabled = true
    replicator_privileged_external_id = "replace with random UUID v4"
    cost_explorer_privileged_external_id = "replace with random UUID v4"
    landing_zone_ou_arns=["arn:aws:organizations::*:ou/o-*/ou-*"]
    EOF
    ```

7. Run

    ```sh
    terraform init
    terraform apply
    ```

8. Access terraform output and pass it securely to meshcloud.

    ```sh
    # The JSON output contains sensitive values that must not be transmitted to meshcloud in plain text.
    terraform output -json
    ```

9. Follow [SSO setup instructions](https://docs.meshcloud.io/docs/meshstack.aws.sso-setup.html).

[^1]: This How-To guides you through the setup from your Cloudshell. You can also run the terraform scripts on your local machine.
[^2]: You can also use other [ways to assign values input variables](https://www.terraform.io/language/values/variables#assigning-values-to-root-module-variables).

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.automation"></a> [aws.automation](#provider\_aws.automation) | n/a |
| <a name="provider_aws.management"></a> [aws.management](#provider\_aws.management) | n/a |
| <a name="provider_aws.meshcloud"></a> [aws.meshcloud](#provider\_aws.meshcloud) | n/a |

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
| <a name="input_cost_explorer_management_account_service_role_name"></a> [cost\_explorer\_management\_account\_service\_role\_name](#input\_cost\_explorer\_management\_account\_service\_role\_name) | n/a | `string` | `"MeshCostExplorerServiceRole"` | no |
| <a name="input_cost_explorer_meshcloud_account_service_user_name"></a> [cost\_explorer\_meshcloud\_account\_service\_user\_name](#input\_cost\_explorer\_meshcloud\_account\_service\_user\_name) | n/a | `string` | `"meshcloud-cost-explorer-user"` | no |
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
