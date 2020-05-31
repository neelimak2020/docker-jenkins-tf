variable "AWS_REGION" {
  description = " AWS region"
}

variable "VPC_CIDR" {
  description = "Ip adedresss for ecs vpc network"

}

variable "VPC_TAGS" {
  description = "tags for vpc ecs environment"
}

variable "ECS_PUBLIC_CIDR" {
  description = "Public 0.0 CIDR for externally accessible subnet"
}

variable "ECS_PRIVATE_CIDR" {
  description = "Private 0.0 CIDR for externally accessible subnet"
}

data "aws_availability_zones" "available" {}
#data "aws_iam_policy_document" "ecs_instance_policy" {}

variable "ECS_AMIS"{
description = " AMIS for AWS region"
type=map(string)

default={
us-east-1 = "ami-0aee8ced190c05726"
us-west-1="ami-0fc0ce1549e302a52"

}
}

variable "ECS_INSTANCE_TYPE" {
  description = " AWS region"
  }

variable "ECS_KEY" {
  description = "ECS key pair name"
}


variable "MIN_INSTANCE_SIZE" {
  description = "Maximum number of instances in the cluster"
}

variable "MAX_INSTANCE_SIZE" {
  description = "Minimum number of instances in the cluster"
}

variable "DESIRED_CAPACITY" {
  description = "Desired number of instances in the cluster"
}

