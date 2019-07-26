resource "kubernetes_role" "demo-kubernetes-role-efs-provisioner" {
  metadata {
    name = "terraform-demo-kubernetes-role-efs-provisioner-leader-locking"
    # namespace = "${kubernetes_namespace.demo-kubernetes-namespace.metadata.0.name}"
  }
  rule {
    api_groups = [""]
    resources  = ["endpoints"]
    verbs      = ["get", "list", "watch", "create", "update", "patch"]
  }
}