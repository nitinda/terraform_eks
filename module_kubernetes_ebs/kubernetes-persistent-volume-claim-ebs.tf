resource "kubernetes_persistent_volume_claim" "demo-eks-persistent-volume-claim-ebs" {
  metadata {
    name = "terraform-demo-eks-persistent-volume-claim-ebs"
    namespace = "${kubernetes_namespace.demo-kubernetes-namespace-ebs-jenkins-master.metadata.0.name}"
    labels {
      app = "ebs-persistent-volume-claim"
    }
  }
  spec {
    storage_class_name = "${kubernetes_storage_class.demo-kubernetes-storage-class-ebs-provisioner.metadata.0.name}"
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "100Gi"
      }
    }
  }
}