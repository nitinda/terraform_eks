# Glboal
variable "region" {
  description = "AWS region that will be used to create resources in."
  default     = "eu-central-1"
}

#### EKS
variable "cluster-name" {
  default = "terraform-demo-eks-cluster"
  type    = "string"
}

variable common_tags {
  description = "Resources Tags"
  type = "map"
  default = {
    Project      = "EKS POC"
    Owner        = "Platform Team"
    Environment  = "prod"
    BusinessUnit = "Platform Team"
  }  
}

####
# data "aws_kms_alias" "demo-key-alias" {
#   provider = "aws.aws_services"
#   name = "alias/uki-cmk-ebs"
# }