output "kubeconfig" {
  value = "${module.aws_resources_module_eks.kubeconfig}"
}

output "config_map_aws_auth" {
  value = "${module.aws_resources_module_eks.config_map_aws_auth}"
}

output "eks_admin_service_account" {
  value = "${module.aws_resources_module_eks.eks_admin_service_account}"
}
