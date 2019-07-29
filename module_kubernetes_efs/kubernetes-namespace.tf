resource "kubernetes_namespace" "demo-kubernetes-namespace" {
  metadata {
    labels {
      app = "efs-provisioner-namespace"
    }
    name = "terraform-demo-kubernetes-namespace"
  }
}