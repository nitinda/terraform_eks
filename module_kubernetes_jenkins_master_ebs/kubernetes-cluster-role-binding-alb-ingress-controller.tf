resource "kubernetes_cluster_role_binding" "demo-kubernetes-cluster-role-binding-alb-ingress-controller" {
  metadata {
    name = "terraform-demo-kubernetes-cluster-role-binding-alb-ingress-controller"
    labels = {
      app = "alb-ingress-controller-cluster-role-binding"
    }
  }
  subject {
    kind      = "ServiceAccount"
    name      = "${kubernetes_service_account.demo-kubernetes-service-account-alb-ingress-controller.metadata.0.name}"
    namespace = "${kubernetes_namespace.demo-kubernetes-namespace-ebs-jenkins-master.metadata.0.name}"
  }
  role_ref {
    kind      = "ClusterRole"
    name      = "${kubernetes_cluster_role.demo-kubernetes-cluster-role-alb-ingress-controller.metadata.0.name}"
    api_group = "${var.cluster_role_binding_api_group}"
  }
}