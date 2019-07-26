# resource "kubernetes_deployment" "demo-kubernetes-deployment-efs-provisioner" {
#   metadata {
#       name = "terraform-demo-kubernetes-deployment-efs-provisioner"
#       labels {
#           app = "terraform-demo-kubernetes-deployment-efs-provisioner"
#       }
#       namespace = "${kubernetes_namespace.demo-kubernetes-namespace.metadata.0.name}"
#   }
#   spec {
#     replicas = 1

#     selector {
#       match_labels {
#         app = "terraform-demo-kubernetes-deployment-efs-provisioner"
#       }
#     }

#     template {
#       metadata {
#         labels {
#           app = "terraform-demo-kubernetes-deployment-efs-provisioner"
#         }
#       }

#       spec {
#         container {
#           image = "quay.io/external_storage/efs-provisioner:latest"
#           name  = "terraform-demo-container-efs-provisioner"
#           command = ["sudo df -h "]
#         #   port {
#         #       container_port = 8080
#         #       host_port = 8080
#         #   }
#           env {
#               name = "FILE_SYSTEM_ID"
#               value = "${var.efs_id}"
#           }
#           env {
#               name = "AWS_REGION"
#               value = "${data.aws_region.demo-current.name}"
#           }
#           env {
#               name = "PROVISIONER_NAME"
#               value = "eks-course/aws-efs"
#           }
#           # env {
#           #     name = "JENKINS_HOME"
#           #     value = "/persistentvolumes"
#           # }
#           volume_mount {
#             # name = "${kubernetes_persistent_volume_claim.demo-eks-persistent-volume-claim-ebs-nginx.metadata.0.name}"
#             name = "pvc-volume"
#             mount_path = "/persistentvolumes"
#           }
#         #   resources{
#         #     limits{
#         #       cpu    = "0.5"
#         #       memory = "512Mi"
#         #     }
#         #     requests{
#         #       cpu    = "250m"
#         #       memory = "50Mi"
#         #     }
#         #   }
#         }
#         volume {
#           name = "pv-volume"
#           nfs {
#               server = "${var.efs_dns_name}"
#               path = "/"
#           }
#           # persistent_volume_claim = ["${kubernetes_persistent_volume_claim.demo-eks-persistent-volume-claim-ebs-nginx.uid}"]
#         }
#       }
#     }
#   }
# }