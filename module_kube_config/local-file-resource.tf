resource "local_file" "demo-local-file-kubconfig" {
  content  = "${var.kubeconfig_output}"
  filename = "${path.cwd}/kubeconfig"
}

resource "local_file" "demo-local-file-config-map-aws-auth" {
  content  = "${var.config_map_aws_auth_output}"
  filename = "${path.cwd}/config-map-aws-auth.yaml"
}

resource "local_file" "demo-local-file-eks-admin-service-account" {
  content  = "${var.eks_admin_service_account_output}"
  filename = "${path.cwd}/eks-admin-service-account.yaml"
}