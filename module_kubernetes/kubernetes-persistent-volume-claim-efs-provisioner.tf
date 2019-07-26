resource "kubernetes_persistent_volume_claim" "demo-eks-persistent-volume-claim-efs-provisioner" {
  metadata {
    name = "terraform-demo-eks-persistent-volume-claim-efs-provisioner"
    # namespace = "${kubernetes_namespace.demo-kubernetes-namespace.metadata.0.name}"
    
    annotations {
      "volume.beta.kubernetes.io/storage-class" = "${kubernetes_storage_class.demo-kubernetes-storage-class-efs-provisioner.metadata.0.name}"
    }
    # labels {
    #   app = "terraform-demo-eks-persistent-volume-claim-efs-provisioner"
    # }
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "1Mi"
      }
    }
  }
#   depends_on = ["kubernetes_deployment.demo-kubernetes-deployment-efs-provisioner","kubernetes_storage_class.demo-kubernetes-storage-class-efs-provisioner"]
}