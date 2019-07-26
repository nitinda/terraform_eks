output "kubeconfig_location" {
  value = "${path.cwd}/kubeconfig"
}

output "null_resource_config_map_aws_auth_id" {
  value = "${null_resource.demo-null-resource-config-map-aws-auth.id}"
}