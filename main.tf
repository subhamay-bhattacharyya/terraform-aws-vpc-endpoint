/*
####################################################################################################
# Terraform Security Group Module Configuration
#
# Description: This module creates VPC Endpoints in AWS with the specified configuration.
#
# Author: Subhamay Bhattacharyya
# Created: 07-Dec-2024 
# Version: 1.0
#
####################################################################################################
*/


# Creates AWS VPC Endpoints based on the provided configuration.
# 
# Arguments:
# - for_each: Iterates over the provided VPC endpoints map.
# - vpc_id: The ID of the VPC in which the endpoint will be used.
# - service_name: The name of the AWS service to which the endpoint will connect.
# - vpc_endpoint_type: The type of VPC endpoint (e.g., Gateway, Interface).
# - route_table_ids: List of route table IDs to be used by the endpoint if the service name is "s3".
# - subnet_ids: List of subnet IDs to be used by the endpoint if the service name is not "s3".
# - security_group_ids: List of security group IDs to be used by the endpoint if the endpoint type is "Interface".
# - private_dns_enabled: Whether or not to enable private DNS for the endpoint if the endpoint type is "Interface".
# - tags: A map of tags to assign to the resource, including a name tag that combines the project name, endpoint name, and CI build identifier.
resource "aws_vpc_endpoint" "vpc_endpoint" {
  for_each            = var.vpc-endpoints
  vpc_id              = var.vpc-id
  service_name        = each.value.service_name
  vpc_endpoint_type   = each.value.endpoint_type
  route_table_ids     = each.value.name == "s3" ? var.route-table-ids : null
  subnet_ids          = each.value.name != "s3" ? var.subnet-ids : null
  security_group_ids  = each.value.endpoint_type == "Interface" ? var.security-group-ids : null
  private_dns_enabled = each.value.endpoint_type == "Interface" ? true : false

  tags = {
    Name = "${var.project-name}-${each.value.name}-endpoint${var.ci-build}"
  }
}