resource "kubernetes_service" "demo-kubernetes-service-ebs-jenkins-master" {
  metadata {
    name = "terraform-demo-kubernetes-service-ebs-jenkins-master"
    namespace = "${kubernetes_namespace.demo-kubernetes-namespace-ebs-jenkins-master.metadata.0.name}"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.demo-kubernetes-deployment-ebs-jenkins-master.metadata.0.labels.app}"
    }      
    port {
        name = "http"
        port = 80
        target_port = 8080
        protocol = "TCP"
    }
    type = "NodePort"
  }
}