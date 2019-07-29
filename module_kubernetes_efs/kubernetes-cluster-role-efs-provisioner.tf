resource "kubernetes_cluster_role" "demo-kubernetes-cluster-role-efs-provisioner" {
  metadata {
    name = "terraform-demo-kubernetes-cluster-role-efs-provisioner-runner"

    labels {
      app = "efs-provisioner-cluster-role-runner"
    }
  }
  rule {
    api_groups = [""]
    resources  = ["persistentvolumes"]
    verbs      = ["get", "list", "watch", "create", "delete"]
  }
  rule {
    api_groups = [""]
    resources  = ["persistentvolumeclaims"]
    verbs      = ["get", "list", "watch", "update"]
  }
  rule {
    api_groups = ["storage.k8s.io"]
    resources  = ["storageclasses"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create", "update", "patch"]
  }
  rule {
    api_groups = [""]
    resources  = ["endpoints"]
    verbs      = ["get", "list", "watch", "create", "update", "patch"]
  }
}