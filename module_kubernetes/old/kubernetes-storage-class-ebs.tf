# resource "kubernetes_storage_class" "demo-kubernetes-storage-class" {
#   metadata {
#     name = "terraform-demo-kubernetes-storage-class"
#     annotations {
#         name = "terraform-demo-kubernetes-storage-class"
#     }
#     labels {
#         name = "terraform-demo-kubernetes-storage-class"
#     }
#   }

#   storage_provisioner = "kubernetes.io/aws-ebs"
#   reclaim_policy = "Retain"
#   parameters = {
#     type = "gp2"
#     zones = "eu-central-1a,eu-central-1b"
#   }
# }