provider "aws" {
    alias   = "aws_services"
    region  = "${var.region}"
}



# Kubernetes Services
data "aws_eks_cluster" "demo-data-aws-eks-cluster" {
  provider = "aws.aws_services"
  name = "${module.aws_resources_module_eks.eks_cluster_name}"
}

data "aws_eks_cluster_auth" "demo-data-aws-eks-cluster-auth" {
  provider = "aws.aws_services"
  name = "${module.aws_resources_module_eks.eks_cluster_name}"
}

provider "kubernetes" {
  alias = "kubernetes_services"
  # config_path = "${module.aws_resources_module_kube_config.kubeconfig_location}"
  cluster_ca_certificate = "${base64decode("${data.aws_eks_cluster.demo-data-aws-eks-cluster.certificate_authority.0.data}")}"
  token = "${data.aws_eks_cluster_auth.demo-data-aws-eks-cluster-auth.token}"
  host = "${data.aws_eks_cluster.demo-data-aws-eks-cluster.endpoint}"
  load_config_file = false
}
