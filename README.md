# meshPlatform AWS Module

meshStack is a Cloud Foundation Platform by meshcloud.

This terraform module is used to integrate AWS into a meshStack instance.

## How to use this Module

1. Login into your AWS Management Account (Root Organization).

    Ensure your organization account user has `IAMFullPermissions`,  `AmazonS3FullAccess` and `AWSOrganizationsFullAccess` permissions.

2. Open your Organization and create two new AWS accounts.

    2.1 Create the `meshcloud` account. The meshStack will use this account to manage AWS accounts in your organization.

    2.2 Create the `automation` account. The meshStack will use this account to manage CloudFormation that are used in [Landing Zones](https://docs.meshcloud.io/docs/meshcloud.landing-zones.html).

3. Prepare permissions for executing the meshPlatform AWS Module.

    3.1 Login into the new `meshcloud` account. Create a new IAM user and create AccessKey-SecretKey which has `IAMFullPermissions` and save the credentials.

    3.2 Login into the new `automation` account. Create a new IAM user and create AccessKey-SecretKey which has `IAMFullPermissions` and save the credentials.

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
    aws configure set profile.management.credential_source Ec2InstanceMetadata
    aws configure --profile meshcloud
    aws configure --profile automation
    ```

    Your credentials file will look like this:

    ```sh
    cat ~/.aws/credentials2
    [management]
    credential_source = Ec2InstanceMetadata
    [meshcloud]
    aws_access_key_id = XXXX
    aws_secret_access_key = XXXX
    [automation]
    aws_access_key_id = XXXX
    aws_secret_access_key = XXXX
    ```

5. Clone the repository `git clone git@github.com:meshcloud/terraform-aws-meshplatform.git` and navigate into it.

6. Create a `variable.tfvars` file and fill in the variables defined in `variables.tf`.[^2]

7. Run `terraform apply`.

8. Read out secret keys.
    The following secrets are needed for integrating AWS as a meshPlatform.

    ```sh
    terraform output replicator_aws_iam_keys
    terraform output kraken_aws_iam_keys
    ```

[^1]: This How-To guides you through the setup from your Cloudshell. You can also run the terraform scripts on your local machine.
[^2]: You can also use other [ways to assign values input variables](https://www.terraform.io/language/values/variables#assigning-values-to-root-module-variables).
