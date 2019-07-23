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
