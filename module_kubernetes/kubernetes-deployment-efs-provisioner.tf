resource "kubernetes_deployment" "demo-kubernetes-deployment-efs-provisioner" {
  metadata {
      name = "terraform-demo-kubernetes-deployment-efs-provisioner"
    #   labels {
    #       app = "terraform-demo-kubernetes-deployment-efs-provisioner"
    #   }
    #   namespace = "${kubernetes_namespace.demo-kubernetes-namespace.metadata.0.name}"
  }
  spec {
    replicas = 1
    strategy {
      type = "Recreate"
    }
    selector {
      match_labels {
        app = "efs-provisioner"
      }
    }
    template {
      metadata {
        labels {
          app = "efs-provisioner"
        }
      }
      spec {
        service_account_name = "${kubernetes_service_account.demo-kubernetes-service-account-efs-provisioner.metadata.0.name}"
        automount_service_account_token = true
        container {
          image = "quay.io/external_storage/efs-provisioner:latest"
          name  = "terraform-demo-container-efs-provisioner"
          env {
              name = "FILE_SYSTEM_ID"
              value_from {
                config_map_key_ref  {
                  name = "${kubernetes_config_map.demo-kubernetes-config-map-efs-provisioner.metadata.0.name}"
                  key = "file.system.id"
                }
              }
          }
          env {
              name = "AWS_REGION"
              value_from {
                config_map_key_ref  {
                  name = "${kubernetes_config_map.demo-kubernetes-config-map-efs-provisioner.metadata.0.name}"
                  key = "aws.region"
                }
              }
          }
          env {
              name = "PROVISIONER_NAME"
              value_from {
                config_map_key_ref  {
                  name = "${kubernetes_config_map.demo-kubernetes-config-map-efs-provisioner.metadata.0.name}"
                  key = "provisioner.name"
                }
              }
          }
          volume_mount {
            name = "pvc-volume"
            mount_path = "/persistentvolumes"
          }
        }
        volume {
          name = "pvc-volume"
          nfs {
              server = "${var.efs_dns_name}"
              path = "/"
          }
        }
      }
    }
  }
}