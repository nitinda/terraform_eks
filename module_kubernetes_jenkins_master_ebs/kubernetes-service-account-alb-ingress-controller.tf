resource "kubernetes_service_account" "demo-kubernetes-service-account-alb-ingress-controller" {
  metadata {
    name = "alb-ingress-controller"
    namespace = "${kubernetes_namespace.demo-kubernetes-namespace-ebs-jenkins-master.metadata.0.name}"
    labels {
      app = "alb-ingress-controller-service-account"
    }
  }
  automount_service_account_token = true
}