resource "kubernetes_namespace" "demo-kubernetes-namespace-efs-jenkins-master" {
  metadata {
    labels {
      app = "efs-jenkins-master-namespace"
    }
    name = "terraform-demo-kubernetes-namespace-efs-jenkins-master"
  }
}