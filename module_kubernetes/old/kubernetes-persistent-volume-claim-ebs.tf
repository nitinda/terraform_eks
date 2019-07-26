# resource "kubernetes_persistent_volume_claim" "demo-eks-persistent-volume-claim-ebs-nginx" {
#   metadata {
#     name = "terraform-demo-eks-persistent-volume-claim-ebs-nginx"
#     namespace = "${kubernetes_namespace.demo-kubernetes-namespace-nginx.metadata.0.name}"
    
#     annotations {
#       name = "terraform-demo-eks-persistent-volume-claim-ebs-nginx"
#     }
#     labels {
#       name = "terraform-demo-eks-persistent-volume-claim-ebs-nginx"
#     }
#   }

#   spec {
#     access_modes = ["ReadWriteOnce"]
#     resources {
#       requests = {
#         storage = "10Gi"
#       }
#     }
#     storage_class_name = "${kubernetes_storage_class.demo-kubernetes-storage-class.metadata.0.name}"
#     # volume_name = "${kubernetes_persistent_volume.demo-eks-persistent-volume-ebs-nginx.metadata.0.name}"
#   }
# }