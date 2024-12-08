![](https://img.shields.io/github/commit-activity/t/subhamay-bhattacharyya/terraform-aws-vpc-endpoint)&nbsp;![](https://img.shields.io/github/last-commit/subhamay-bhattacharyya/terraform-aws-vpc-endpoint)&nbsp;![](https://img.shields.io/github/release-date/subhamay-bhattacharyya/terraform-aws-vpc-endpoint)&nbsp;![](https://img.shields.io/github/repo-size/subhamay-bhattacharyya/terraform-aws-vpc-endpoint)&nbsp;![](https://img.shields.io/github/directory-file-count/subhamay-bhattacharyya/terraform-aws-vpc-endpoint)&nbsp;[](https://img.shields.io/github/issues/subhamay-bhattacharyya/terraform-aws-vpc-endpoint)&nbsp;![](https://img.shields.io/github/languages/top/subhamay-bhattacharyya/terraform-aws-vpc-endpoint)&nbsp;![](https://img.shields.io/github/commit-activity/m/subhamay-bhattacharyya/terraform-aws-vpc-endpoint)&nbsp;![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/bsubhamay/c2a546ba2cbc92fe2cf75a36a9b8d669/raw/terraform-aws-vpc-endpoint.json?)

# Terraform AWS VPC Endpoint Module

### Example Usage:

```hcl
module "vpc_endpoints" {
  source  = "app.terraform.io/subhamay-bhattacharyya/vpc-endpoints/aws"
  version = "1.0.0"

  aws_region       = "us-east-1"
  environment_name = "devl"
  vpc_id           = "your-vpc-id"
  vpc_endpoints    = {
    ssm = {
      name          = "ssm"
      endpoint_type = "Interface"
      service_name  = "com.amazonaws.${var.aws_region}.ssm"
    }
    ec2messages = {
      name          = "ec2messages"
      endpoint_type = "Interface"
      service_name  = "com.amazonaws.${var.aws_region}.ec2messages"
    }
    ssmmessages = {
      name          = "ssmmessages"
      endpoint_type = "Interface"
      service_name  = "com.amazonaws.${var.aws_region}.ssmmessages"
    }
    s3 = {
      name          = "s3"
      endpoint_type = "Gateway"
      service_name  = "com.amazonaws.${var.aws_region}.s3"
    }
    kms = {
      name          = "kms"
      endpoint_type = "Interface"
      service_name  = "com.amazonaws.${var.aws_region}.kms"
    }
  }
}
```

##### Default tags

```hcl
locals {
  tags = {
    Environment      = var.environment-name
    ProjectName      = var.project-name
    GitHubRepository = var.github-repo
    GitHubRef        = var.github-ref
    GitHubURL        = var.github-url
    GitHubSHA        = var.github-sha
  }
}
```
#### Note

- The VPC endpoints are created based on a map variable `vpc_endpoints`. This map allows you to define multiple VPC endpoints with their respective configurations. Each endpoint is represented as an object with attributes such as `name`, `endpoint_type`, and `service_name`. This provides flexibility to specify different types of endpoints (e.g., Interface, Gateway) and connect to various AWS services within your VPC.

## Inputs


| Name| Description|Type|Default|Required|
|---   |---	|---	|---	|---	|
| aws-region                | The AWS region where the VPC endpoints will be created                      | string | us-east-1     | yes      |
| environment-name          | The environment name (e.g., "devl", "test", "prod")                         | string | devl          | yes      |
| vpc-id                    | The VPC ID where the endpoints will be created                              | string | n/a           | yes      |
| vpc-endpoints             | A map of VPC endpoints with their configurations                            | map    | {}            | yes      |
| project-name              | The name of the project                                                     | string | n/a           | yes      |
| github-repo               | The GitHub repository name                                                  | string | ""            | no       |
| github-ref                | The GitHub reference (branch or tag)                                        | string | ""            | no       |
| github-url                | The GitHub URL                                                              | string | ""            | no       |
| github-sha                | The GitHub commit SHA                                                       | string | ""            | no       |
|ci-build	                  |A string representing the CI build identifier	                              | string | ""	           | yes      |

## Outputs

| Name| Description|
|--- |--- |
| vpc-endpoint-ids |A map of VPC endpoint IDs created by this module. |