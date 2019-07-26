resource "kubernetes_storage_class" "demo-kubernetes-storage-class-efs-provisioner" {
  metadata {
    name = "terraform-demo-kubernetes-storageclass-aws-efs-provisioner"
    # annotations {
    #     name = "terraform-demo-kubernetes-storage-class-efs-provisioner"
    # }
    # labels {
    #     app = "terraform-demo-kubernetes-storage-class-efs-provisioner"
    # }
  }
  storage_provisioner = "${var.efs_provisioner}"
}