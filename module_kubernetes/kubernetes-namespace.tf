resource "kubernetes_namespace" "demo-kubernetes-namespace" {
  metadata {
    annotations {
      name = "terraform-demo-kubernetes-namespace-annotation"
    }

    labels {
      mylabel = "terraform-demo-kubernetes-namespace-label"
    }

    name = "terraform-demo-kubernetes-namespace"
  }
}