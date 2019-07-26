variable depends_on { default = [], type = "list"}

variable "kubeconfig_output" {
  description = "description"
}

variable "config_map_aws_auth_output" {
  description = "description"
}

variable "eks_admin_service_account_output" {
  description = "description"
}

variable "kubernetes_dashboard_url" {
  description = "description"
  default = "https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml"
}
