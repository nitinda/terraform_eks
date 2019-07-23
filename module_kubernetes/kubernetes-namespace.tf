resource "kubernetes_namespace" "demo-kubernetes-namespace-nginx" {
  metadata {
    annotations {
      name = "terraform-demo-kubernetes-annotation"
    }

    labels {
      mylabel = "terraform-demo-kubernetes-label"
    }

    name = "terraform-demo-kubernetes-namespace-nginx"
  }
}