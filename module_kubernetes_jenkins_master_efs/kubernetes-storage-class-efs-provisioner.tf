resource "kubernetes_storage_class" "demo-kubernetes-storage-class-efs-provisioner" {
  metadata {
    name = "terraform-demo-kubernetes-storageclass-aws-efs-provisioner"
    labels {
        app = "efs-provisioner-storage-class"
    }
  }
  storage_provisioner = "${var.efs_provisioner}"
}