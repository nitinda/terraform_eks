terraform {
  required_version = ">= 0.11.7"
}

module "aws_resources_module_network" {
  source  = "../module_network"

  providers = {
    "aws"  = "aws.aws_services"
  }

  cluster-name = "${var.cluster-name}"
  common_tags = "${var.common_tags}"
}

module "aws_resources_module_efs" {
  source  = "../module_efs"

  providers = {
    "aws"  = "aws.aws_services"
  }

  cluster-name = "${var.cluster-name}"
  common_tags = "${var.common_tags}"
  vpc_id = "${module.aws_resources_module_network.vpc_id}"
  vpc_cidr = "${module.aws_resources_module_network.vpc_cidr}"
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
  common_tags = "${var.common_tags}"
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
  config_map_aws_auth_output = "${module.aws_resources_module_eks.config_map_aws_auth}"
  eks_admin_service_account_output = "${module.aws_resources_module_eks.eks_admin_service_account}"

  depends_on = ["${module.aws_resources_module_eks.eks_worker_node_autoscaling_group_id}","${module.aws_resources_module_eks.kubeconfig}","${module.aws_resources_module_eks.config_map_aws_auth}","${module.aws_resources_module_eks.eks_admin_service_account}"]
}

module "aws_resources_module_kubernetes_efs" {
  source  = "../module_kubernetes_efs"

  providers = {
    "kubernetes" = "kubernetes.kubernetes_services"
  }

  efs_dns_name = "${module.aws_resources_module_efs.efs_dns_name}"
  efs_id = "${module.aws_resources_module_efs.efs_id}"
  efs_provisioner = "efs-provisioner/aws-efs"
  cluster_role_binding_api_group = "rbac.authorization.k8s.io"
  role_binding_api_group = "rbac.authorization.k8s.io"

  depends_on = ["${module.aws_resources_module_eks.eks_worker_node_autoscaling_group_id}","${module.aws_resources_module_eks.kubeconfig}","${module.aws_resources_module_kube_config.kubeconfig_location}","${module.aws_resources_module_kube_config.null_resource_config_map_aws_auth_id}"]
}