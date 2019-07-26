variable "cluster-name" {
  type    = "string"
}
variable common_tags {
  description = "Resources Tags"
  type = "map"
}

locals {
  workstation-external-cidr = "${chomp(data.http.demo-workstation-external-ip.body)}/32"
}

variable depends_on { default = [], type = "list"}


variable "vpc_id" {
  description = "description"
}

variable "vpc_cidr" {
  description = "description"
}
variable "web_subnet_ids" {
  description = "description"
  type = "list"
}

variable "public_subnet_ids" {
  description = "description"
  type = "list"
}

variable "efs_mount_target_ip_address" {
  description = "description"
  type = "list"
}
