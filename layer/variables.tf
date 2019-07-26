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