resource "kubernetes_deployment" "demo-kubernetes-deployment-ebs-jenkins-master" {
  metadata {
      name = "terraform-demo-kubernetes-deployment-ebs-jenkins-master"
      labels {
        app = "ebs-jenkins-master-deployment"
      }
      namespace = "${kubernetes_namespace.demo-kubernetes-namespace-ebs-jenkins-master.metadata.0.name}"
  }
  spec {
    replicas = 1
    selector {
      match_labels {
        app = "ebs-jenkins-master-deployment"
      }
    }
    template {
      metadata {
        labels {
          app = "ebs-jenkins-master-deployment"
          name = "ebs-jenkins-master-deployment"
        }
      }
      spec {
        
        automount_service_account_token = true
        container {
          image = "jenkins/jenkins"
          name  = "terraform-demo-container-ebs-jenkins-master"
          security_context {
            allow_privilege_escalation = true
          }
          port {
            name           = "http"
            container_port = 8080
            host_port      = 9090
            protocol       = "TCP"
          }
          env {
              name = "JENKINS_HOME"
              value = "/ebs/jenkins"
          }
          # liveness_probe {
          #   tcp_socket {
          #     port = 8080
          #   }
          #   failure_threshold     = 3
          #   initial_delay_seconds = 3
          #   period_seconds        = 10
          #   success_threshold     = 1
          #   timeout_seconds       = 2
          # }
          # readiness_probe {
          #   tcp_socket {
          #     port = 8080
          #   }
          #   failure_threshold     = 1
          #   initial_delay_seconds = 10
          #   period_seconds        = 10
          #   success_threshold     = 1
          #   timeout_seconds       = 2
          # }
          resources {
            limits {
              cpu    = "512m"
              memory = "1024M"
            }
          }
          volume_mount {
            mount_path = "/ebs/jenkins"
            name       = "ebs-volume"
          }
        }        
        volume {
          name = "ebs-volume"
          persistent_volume_claim {
            claim_name = "${kubernetes_persistent_volume_claim.demo-eks-persistent-volume-claim-ebs.metadata.0.name}"
          }
        }
      }
    }
  }
}