resource "kubernetes_service_account" "demo-kubernetes-service-account-efs-provisioner" {
  metadata {
    name = "efs-provisioner"
    namespace = "${kubernetes_namespace.demo-kubernetes-namespace.metadata.0.name}"
    labels {
      app = "efs-provisioner-service-account"
    }
  }
  automount_service_account_token = true
}