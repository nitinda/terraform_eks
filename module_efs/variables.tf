variable "cluster-name" {
  type    = "string"
}

locals {
  common_tags = {
    Project = "EKS POC"
    Owner   = "Platform Team"
    Environment = "prod"
    BusinessUnit = "Platform Team"
  }
}

locals {
  Project = "EKS POC"
  Owner   = "Platform Team"
  Environment = "prod"
  BusinessUnit = "Platform Team"
}

variable depends_on { default = [], type = "list"}

variable "vpc_id" {
  description = "description"
}

variable "web_subnet_cidr" {
  description = "description"
  type = "list"
}

variable "web_subnet_ids" {
  description = "description"
  type = "list"
}
