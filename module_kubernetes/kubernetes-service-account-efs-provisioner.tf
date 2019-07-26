resource "kubernetes_service_account" "demo-kubernetes-service-account-efs-provisioner" {
  metadata {
    name = "efs-provisioner"
    # namespace = "${kubernetes_namespace.demo-kubernetes-namespace.metadata.0.name}"
    annotations {
        name = "terraform-demo-kubernetes-service-account-efs-provisioner"
    }
    labels {
      app = "terraform-demo-kubernetes-service-account-efs-provisioner"
    }
  }
  automount_service_account_token = true
}