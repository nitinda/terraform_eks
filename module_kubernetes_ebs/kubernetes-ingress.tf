resource "kubernetes_ingress" "demo-kubernetes-ingress" {
  metadata {
    name = "terraform-demo-kubernetes-ingress"
    annotations {
        "kubernetes.io/ingress.class" = "alb"
        "alb.ingress.kubernetes.io/scheme" = "internet-facing"
        "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTPS\": 443}]"
        "alb.ingress.kubernetes.io/healthcheck-protocol" = "HTTP"
        "alb.ingress.kubernetes.io/healthcheck-port" = "9090"
        "alb.ingress.kubernetes.io/healthcheck-path" = "/login"
        "alb.ingress.kubernetes.io/success-codes" = "200-300"
        "alb.ingress.kubernetes.io/healthcheck-timeout-seconds" = "3"
        "alb.ingress.kubernetes.io/healthy-threshold-count" = "2"
        "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = "5"
        "alb.ingress.kubernetes.io/certificate-arn" = "${var.certificate_arn}"
        "alb.ingress.kubernetes.io/tags" = "Environment=${var.common_tags["Environment"]},BusinessUnit=${var.common_tags["BusinessUnit"]},Owner=${var.common_tags["Owner"]},Project=${var.common_tags["Project"]}"
    }
    labels {
        app = "alb-ingress"
    }
    namespace = "${kubernetes_namespace.demo-kubernetes-namespace-ebs-jenkins-master.metadata.0.name}"
  }

  spec {
    backend {
      service_name = "${kubernetes_service.demo-kubernetes-service-ebs-jenkins-master.metadata.0.name}"
      service_port = 80
    }
    # rule {
    #   http {
    #     path {
    #       backend {
    #         service_name = "${kubernetes_service.demo-kubernetes-service-jenkins-ebs.metadata.0.name}"
    #         service_port = 80
    #       }
    #     }
    #   }
    # }
    tls {
      secret_name = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
    }
  }
}
