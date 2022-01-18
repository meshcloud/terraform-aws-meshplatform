# terraform-aws-meshplatform



1. Login into your Management (Root Organization) account
2. Open your Organization and create 2 new accounts
2.1 Create `meshcloud` account ( the meshcloud backend servers will use this account to access the organization root account )
2.2 Create `automation` account ( to build automations with meshcloud Landing Zones )
3. Login into the new `meshcloud` and `automation` account. Create a new IAM user for both of these accounts and create AccessKey-SecretKey which has IAMFullPermissions and save the credentials. The terraform deployment will use these credentials to access these accounts.
3.1 The organization(root) account user needs `IAMFullPermissions`, `AmazonS3FullAccess` and `AWSOrganizationsFullAccess` permissions.
4. Open AWS CloudShell Service on your Root management account
4.1 Install terraform into Cloudshell.
########## Terminal Commands For Amazon Linux ######
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
##########
4.2 Add the configuration below into ~/.aws/credentials file.
4.2.1 Execute `mkdir -p ~/.aws/`
4.2.2 Execute `sudo vi ~/.aws/credentials`
########## ~/.aws/credentials file ######
[management]
credential_source = Ec2InstanceMetadata
[meshcloud]
aws_access_key_id = XXXX
aws_secret_access_key = XXXX
[automation]
aws_access_key_id = XXXX
aws_secret_access_key = XXXX
##########
4.3 (Optional method) To create these credentials file, terminal commands can also be used.
########## Terminal Commands ######
aws configure set profile.management.credential_source Ec2InstanceMetadata
aws configure --profile meshcloud
aws configure --profile automation
##########
5 Set the terraform variables
5.1 Set Terraform `backend` is the location that the terraform state files are stored. Using AWS S3 service makes them safely stored in your Cloud service, so the future updates can be executed without any problem. If you don't want to store it on your Cloud provider, you can also choose local storage but then we advise that you should keep the state file in safe place.
5.2 Open replicator.tf file and follow the instructions
5.3 Open cost-explorer.tf file and follow the instructions
6 Give the outputs to the operator.
6.1 There are sensitive outputs. To make them visible, you should execute the following commands:
########## Export the sensitive outputs  ######
terraform output replicator_aws_iam_keys
terraform output kraken_aws_iam_keys
