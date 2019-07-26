# resource "kubernetes_persistent_volume" "demo-eks-persistent-volume-ebs-nginx" {
#   metadata {
#     name = "terraform-demo-eks-persistent-volume-ebs-nginx"
#   }
#   spec {
#     capacity = {
#       storage = "10Gi"
#     }
#     access_modes = ["ReadWriteMany"]
#     persistent_volume_source {
#       aws_elastic_block_store {
#           fs_type = "ext4"
#           volume_id = "${data.aws_ebs_volume.demo-ebs-volume.volume_id}"
#       }
#     }
#   }
# }