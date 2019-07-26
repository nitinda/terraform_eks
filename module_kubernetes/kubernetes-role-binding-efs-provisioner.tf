resource "kubernetes_role_binding" "demo-kubernetes-role-binding-efs-provisioner" {
  metadata {
    name = "terraform-demo-kubernetes-role-binding-efs-provisioner-leader-locking"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "${kubernetes_service_account.demo-kubernetes-service-account-efs-provisioner.metadata.0.name}"
    # namespace = "${kubernetes_namespace.demo-kubernetes-namespace.metadata.0.name}"
  }
  role_ref {
    kind      = "Role"
    name      = "${kubernetes_role.demo-kubernetes-role-efs-provisioner.metadata.0.name}"
    api_group = "${var.role_binding_api_group}"
  }
}