resource "kubernetes_cluster_role_binding" "demo-kubernetes-cluster-role-binding-efs-provisioner" {
  metadata {
    name = "terraform-demo-kubernetes-cluster-role-binding-efs-provisioner-run"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "${kubernetes_service_account.demo-kubernetes-service-account-efs-provisioner.metadata.0.name}"
    # namespace = "${kubernetes_namespace.demo-kubernetes-namespace.metadata.0.name}"
  }
  role_ref {
    kind      = "ClusterRole"
    name      = "${kubernetes_cluster_role.demo-kubernetes-cluster-role-efs-provisioner.metadata.0.name}"
    api_group = "${var.cluster_role_binding_api_group}"
  }
}