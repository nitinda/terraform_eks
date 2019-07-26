# resource "kubernetes_service" "demo-kubernetes-service-nginx" {
#   metadata {
#     name = "terraform-demo-kubernetes-service-nginx"
#     namespace = "${kubernetes_namespace.demo-kubernetes-namespace-nginx.metadata.0.name}"
#   }

#   spec {
#     selector {
#       app = "${kubernetes_deployment.demo-kubernetes-deployment-nginx.metadata.0.labels.app}"
#       # app = "${kubernetes_pod.demo-kubernetes-pod-nginx.metadata.0.labels.app}"
#     }
#     session_affinity = "None"
#     port {
#         name = "http"
#         port = 80
#         target_port = 80
#         protocol = "TCP"
#     }

#     type = "LoadBalancer"
#   }
# }