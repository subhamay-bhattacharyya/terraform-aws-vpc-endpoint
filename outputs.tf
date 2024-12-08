/*
####################################################################################################
# Terraform Security Group Module Outputs Configuration
#
# Description: This module creates a Security Group in AWS with the specified rules.
#
# Author: Subhamay Bhattacharyya
# Created: 07-Dec-2024 
# Version: 1.0
#
####################################################################################################
*/

output "vpc-endpoint" {
  value = {
    vpc_endpoint = aws_vpc_endpoint.vpc_endpoint.*
  }
}
