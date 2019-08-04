resource "kubernetes_namespace" "demo-kubernetes-namespace-ebs-jenkins-master" {
  metadata {
    annotations {
      name = "terraform-demo-ebs-jenkins-master"
    }
    labels {
      app = "ebs-jenkins-master-namespace"
    }
    name = "terraform-demo-ebs-jenkins-master"
  }
}