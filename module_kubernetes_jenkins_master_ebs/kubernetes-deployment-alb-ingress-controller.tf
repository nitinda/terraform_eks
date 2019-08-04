resource "kubernetes_deployment" "demo-kubernetes-deployment-alb-ingress-controller" {
  metadata {
      name = "terraform-demo-kubernetes-deployment-alb-ingress-controller"
      labels {
        app = "alb-ingress-controller-deployment"
      }
      namespace = "${kubernetes_namespace.demo-kubernetes-namespace-ebs-jenkins-master.metadata.0.name}"
  }
  spec {
    replicas = 1
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge = 1
        max_unavailable = 1 
      }
    }
    selector {
      match_labels {
        app = "alb-ingress-controller-deployment"
      }
    }
    template {
      metadata {
        labels {
          app = "alb-ingress-controller-deployment"
          name = "alb-ingress-controller-deployment"
        }
      }
      spec {
        service_account_name = "${kubernetes_service_account.demo-kubernetes-service-account-alb-ingress-controller.metadata.0.name}"        
        automount_service_account_token = true
        container {
          image = "894847497797.dkr.ecr.us-west-2.amazonaws.com/aws-alb-ingress-controller:v1.0.0"
          name  = "terraform-demo-container-alb-ingress-controller"
          image_pull_policy = "Always"
          security_context {
            allow_privilege_escalation = true
          }
          args = [
            "--ingress-class=alb",
            "--watch-namespace=${kubernetes_namespace.demo-kubernetes-namespace-ebs-jenkins-master.metadata.0.name}",
            "--cluster-name=${var.cluster-name}",
            "--backend-protocol=HTTP",
            "--aws-region=${data.aws_region.demo-current.name}",
            "--alb-name-prefix=alb-ingres",
            "--aws-vpc-id=${var.vpc_id}",
            "-v=4"
          ]
        }
      }
    }
  }
}