resource "local_file" "demo-null-resource-kubconfig" {
  content  = "${var.kubeconfig_output}"
  filename = "${path.cwd}/kubeconfig"
}