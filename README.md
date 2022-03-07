# AWS meshPlatform Module

meshStack is a Cloud Foundation Platform by meshcloud. AWS is a proprietary public cloud platform provided by Amazon Web Services. meshStack supports project and user management for AWS to include AWS services into cloud projects managed by meshStack.

This terraform module is used to integrate AWS into a meshStack instance as a meshPlatform. More information on the integration can be found on [meshcloud public docs](https://docs.meshcloud.io/docs/meshstack.aws.index.html).

## Prerequisites

- 3 IAM users in 3 AWS accounts with `IAMFullAccess`:
  - management account: Your existing organization (or root) account that all other accounts are under.
  - meshcloud account: meshStack will use this account to manage AWS accounts in your organization.
  - automation account: meshStack will use this account to manage CloudFormation that are used in [Landing Zones](https://docs.meshcloud.io/docs/meshcloud.landing-zones.html).
  
  Include those IAM users' access and secret keys in your `~/.aws/credentials` file as follows:

  ```ini
    [management]
    aws_access_key_id = XXXX
    aws_secret_access_key = XXXX
    [meshcloud]
    aws_access_key_id = XXXX
    aws_secret_access_key = XXXX
    [automation]
    aws_access_key_id = XXXX
    aws_secret_access_key = XXXX
  ```

- [Terraform installed](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [AWS CLI installed](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Module Structure

For an overview of the module structure, refer to [generated terraform docs](./TERRAFORM_DOCS.md)

## How to Use This Module

### Using AWS Portal

1. Open AWS CloudShell Service on your management account.[^1]

    - Install terraform into CloudShell.

      ```sh
      # Terminal Commands For Amazon Linux
      sudo yum install -y yum-utils
      sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
      sudo yum -y install terraform
      ```

    - Configure credentials for AWS CLI.

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

2. Download the example `main.tf` and `outputs.tf` files.

    ```sh
    # Downloads main.tf and outputs.tf files into ~/terraform-aws-meshplatform
    wget https://raw.githubusercontent.com/meshcloud/terraform-aws-meshplatform/main/examples/basic-aws-integration/main.tf -O ~/terraform-aws-meshplatform/main.tf
    wget https://raw.githubusercontent.com/meshcloud/terraform-aws-meshplatform/main/examples/basic-aws-integration/outputs.tf -O ~/terraform-aws-meshplatform/outputs.tf
    ```

3. Open `~/terraform-aws-meshplatform/main.tf` with a text editor. Modify the module variables and Terraform state backend settings in the file.

4. Execute the module.

    ```sh
    # Changes into ~/terraform-aws-meshplatform and applies terraform
    cd ~/terraform-aws-meshplatform
    terraform init
    terraform apply
    ```

5. Access terraform output and pass it securely to meshcloud.

    ```sh
    # The JSON output contains sensitive values that must not be transmitted to meshcloud in plain text.
    terraform output -json
    ```

## Example Usages

Check [examples](./examples/) for different use cases. As a quick start we recommend using [basic-aws-integration](./examples/basic-aws-integration) example.

[^1]: This How-To guides you through the setup from your Cloudshell. You can also run the terraform scripts on your local machine.
[^2]: You can also use other [ways to assign values input variables](https://www.terraform.io/language/values/variables#assigning-values-to-root-module-variables).
