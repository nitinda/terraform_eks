variable depends_on { default = [], type = "list"}

variable "ebs_provisioner" {
  description = "description"
}

variable "kms_key_id" {
  description = "description"
}

variable "cluster_role_binding_api_group" {
  description = "description"
}

variable "cluster-name" {
  description = "description"
}

variable "vpc_id" {
  description = "description"
}

variable common_tags {
  description = "Resources Tags"
  type = "map"
}

variable "certificate_arn" {
  description = "description"
}
