terraform {
  required_version = ">= 0.11.7"
}


module "aws_resources_module_network" {
  source  = "../module_network"

  providers = {
    "aws"  = "aws.aws_services"
  }
  cluster-name = "${var.cluster-name}"
}

module "aws_resources_module_efs" {
  source  = "../module_efs"

  providers = {
    "aws"  = "aws.aws_services"
  }

  cluster-name = "${var.cluster-name}"
  vpc_id = "${module.aws_resources_module_network.vpc_id}"
  web_subnet_cidr = "${module.aws_resources_module_network.web_subnet_cidr_blocks}"
  web_subnet_ids = "${module.aws_resources_module_network.web_subnet_ids}"

  depends_on = ["${module.aws_resources_module_network.nat_gateway_ids}"]
}

module "aws_resources_module_eks" {
  source  = "../module_eks"

  providers = {
    "aws"  = "aws.aws_services"
  }
  
  cluster-name = "${var.cluster-name}"
  vpc_id = "${module.aws_resources_module_network.vpc_id}"
  vpc_cidr = "${module.aws_resources_module_network.vpc_cidr}"
  web_subnet_ids = "${module.aws_resources_module_network.web_subnet_ids}"
  public_subnet_ids = "${module.aws_resources_module_network.public_subnet_ids}"
  efs_mount_target_ip_address = "${module.aws_resources_module_efs.efs_mount_target_ip_address}"

  depends_on = ["${module.aws_resources_module_efs.efs_mount_target_ids}","${module.aws_resources_module_network.nat_gateway_ids}"]
  
}

module "aws_resources_module_kube_config" {
  source  = "../module_kube_config"

  providers = {
    "aws"  = "aws.aws_services"
  }
  kubeconfig_output = "${module.aws_resources_module_eks.kubeconfig}"
  depends_on = ["${module.aws_resources_module_eks.kubeconfig}"]
}

# module "aws_resources_module_kubernetes" {
#   source  = "../module_kubernetes"

#   providers = {
#     "kubernetes" = "kubernetes.kubernetes_services"
#   }

#   depends_on = ["${module.aws_resources_module_eks.kubeconfig}","${module.aws_resources_module_kube_config.kubeconfig_location}"]
# }