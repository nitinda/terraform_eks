output "kubeconfig" {
  value = "${module.aws_resources_module_eks.kubeconfig}"
}

output "config-map-aws-auth" {
  value = "${module.aws_resources_module_eks.config-map-aws-auth}"
}