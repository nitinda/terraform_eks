resource "kubernetes_service" "demo-kubernetes-service-efs-jenkins-master" {
  metadata {
    name = "terraform-demo-kubernetes-service-efs-jenkins-master"
    namespace = "${kubernetes_namespace.demo-kubernetes-namespace-efs-jenkins-master.metadata.0.name}"
  }

  spec {
    selector {
      run = "${kubernetes_deployment.demo-kubernetes-deployment-efs-jenkins.metadata.0.labels.run}"
    }      
    session_affinity = "None"
    port {
        name = "http"
        port = 80
        target_port = 8080
        protocol = "TCP"
    }
    type = "LoadBalancer"
  }
}