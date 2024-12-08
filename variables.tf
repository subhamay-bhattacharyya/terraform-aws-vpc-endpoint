/*
####################################################################################################
# Terraform Security Group Module Variabls Configuration
#
# Description: This module creates VPC Endpoints in AWS with the specified configuration.
#
# Author: Subhamay Bhattacharyya
# Created: 07-Dec-2024 
# Version: 1.0
#
####################################################################################################
*/

######################################## AWS Configuration #########################################
# This variable defines the AWS region where the resources will be created.
# It is of type string and defaults to "us-east-1".
variable "aws-region" {
  type    = string
  default = "us-east-1"
}

######################################## Project Name ##############################################
# This variable defines the name of the project.
# It is a string type variable with a default value of "your-project-name".
# You can override this default value by providing a different project name.
variable "project-name" {
  description = "The name of the project"
  type        = string
  default     = "your-project-name"
}

######################################## Environment Name ##########################################
# This variable defines the environment name where the resources will be deployed.
# 
# Options:
# - devl : Development
# - test : Test
# - prod : Production
#
# Default value: devl
#
# Validation:
# The value must be one of the following: "devl", "test", or "prod".
# If the value does not match any of these options, an error message "Err: environment is not valid." will be displayed.
variable "environment-name" {
  type        = string
  description = <<EOF
  (Optional) The environment in which to deploy our resources to.

  Options:
  - devl : Development
  - test: Test
  - prod: Production

  Default: devl
  EOF
  default     = "devl"

  validation {
    condition     = can(regex("^devl$|^test$|^prod$", var.environment-name))
    error_message = "Err: environment is not valid."
  }
}

######################################## VPC Endpoint ##############################################
# This variable defines a map of VPC endpoints.
# Each endpoint is represented as an object with the following attributes:
# - name: The name of the VPC endpoint (string).
# - endpoint_type: The type of the VPC endpoint, e.g., Interface or Gateway (string).
# - service_name: The name of the AWS service to which the endpoint connects (string).
# 
# The default value includes an example endpoint for the AWS Systems Manager (SSM) service.
variable "vpc-endpoints" {
  description = "A map of VPC endpoints"
  type = map(object({
    name          = string
    endpoint_type = string
    service_name  = string
  }))
  default = {
    ssm = {
      name          = "ssm"
      endpoint_type = "Interface"
      service_name  = "com.amazonaws.us-east-1.ssm"
    }
  }
}


# This variable defines the ID of the VPC associated with the VPC Endpoints.
# 
# Type: string
# Description: VPC Id associated with the VPC Endpoints.
# Default: ""
variable "vpc-id" {
  type        = string
  description = "VPC Id associated with the VPC Endpoints."
  default     = ""
}

# This variable defines a list of subnet IDs associated with the VPC Endpoint.
# 
# Type: list(string)
# 
# Example usage:
# 
# variable "subnet-ids" {
#   type        = list(string)
#   description = "Subnet ids associated with the VPC Endpoint"
# }
# 
# subnet-ids = ["subnet-12345678", "subnet-87654321"]
variable "subnet-ids" {
  type        = list(string)
  description = "Subnet ids associated with the VPC Endpoint"
}

# This variable defines a list of security group IDs associated with the VPC Endpoint.
# 
# Type: list(string)
# 
# Description: 
# - Id of the security group associated with the VPC Endpoint
variable "security-group-ids" {
  type        = list(string)
  description = "Id of the security group associated with the VPC Endpoint"
}

# This variable defines a list of route table IDs to be used in the configuration.
# 
# Type: list(string)
# 
# Description: 
#   - route-table-ids: A list of route table IDs that will be associated with the VPC endpoint.
variable "route-table-ids" {
  type        = list(string)
  description = "List of route table ids"
}

######################################## GitHub ####################################################
# The CI build string
# This variable defines the CI build string.
# It is a string type variable with a default value of an empty string.
variable "ci-build" {
  description = "The CI build string"
  type        = string
  default     = ""
}