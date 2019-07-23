resource "kubernetes_deployment" "demo-kubernetes-deployment-nginx" {
  metadata {
      name = "terraform-demo-kubernetes-deployment-nginx"
      labels {
          app = "terraform-demo-kubernetes-deployment-nginx"
      }
      namespace = "${kubernetes_namespace.demo-kubernetes-namespace-nginx.metadata.0.name}"
  }
  spec {
    replicas = 1

    selector {
      match_labels {
        app = "terraform-demo-kubernetes-deployment-nginx"
      }
    }

    template {
      metadata {
        labels {
          app = "terraform-demo-kubernetes-deployment-nginx"
        }
      }

      spec {
        container {
          image = "nginx:1.7.9"
          name  = "terraform-demo-container-nginx"
          port {
              container_port = 80
          }
          # volume_mount {
          #   name = "${kubernetes_persistent_volume_claim.demo-eks-persistent-volume-claim-ebs-nginx.metadata.0.name}"
          #   mount_path = "/data"
          # }
          resources{
            limits{
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests{
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
        # volume {
        #   name = "terraform-demo-eks-persistent-volume-ebs-nginx"
        #   # persistent_volume_claim = ["${kubernetes_persistent_volume_claim.demo-eks-persistent-volume-claim-ebs-nginx.uid}"]
        # }
      }
    }
  }
}