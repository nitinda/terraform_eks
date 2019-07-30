output "kubernetes_ingress_load_balancer_ingress" {
  value = "${kubernetes_ingress.demo-kubernetes-ingress.load_balancer_ingress.0.hostname}"
}
