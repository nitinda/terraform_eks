provider "aws" {
    alias   = "aws_services"
    region  = "${var.region}"
}

provider "kubernetes" {
  alias = "kubernetes_services"
  config_path = "${module.aws_resources_module_kube_config.kubeconfig_location}"
}
