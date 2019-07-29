resource "kubernetes_deployment" "demo-kubernetes-deployment-efs-jenkins" {
  metadata {
      name = "terraform-demo-kubernetes-deployment-efs-jenkins"
      namespace = "${kubernetes_namespace.demo-kubernetes-namespace.metadata.0.name}"
      labels {
        run = "efs-jenkins-deployment"
      }
  }
  spec {
    replicas = 1

    selector {
      match_labels {
        run = "efs-jenkins-deployment"
      }
    }
    template {
      metadata {
        labels {
          run = "efs-jenkins-deployment"
        }
      }
      spec {
        container {
          image = "jenkins/jenkins"
          name  = "terraform-demo-container-efs-jenkins"
          port {
              container_port = 8080
          }
          env {
              name = "JENKINS_HOME"
              value = "/efs/jenkins"
          }
          volume_mount {
            name = "efs-jenkins"
            mount_path = "/efs/jenkins"
          }
          resources{
            limits{
              cpu    = "0.5"
              memory = "2048Mi"
            }
            requests{
              cpu    = "250m"
              memory = "500Mi"
            }
          }
          readiness_probe {
            tcp_socket {
              port = 8080
            }
            failure_threshold     = 1
            initial_delay_seconds = 10
            period_seconds        = 10
            success_threshold     = 1
            timeout_seconds       = 2
          }
        }
        volume {
          name = "efs-jenkins"
          persistent_volume_claim {
              claim_name = "${kubernetes_persistent_volume_claim.demo-eks-persistent-volume-claim-efs-provisioner.metadata.0.name}"
          }
        }
      }
    }
  }
}