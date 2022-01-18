# You need this policy to execute necessary actions on your Terraform providers.
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