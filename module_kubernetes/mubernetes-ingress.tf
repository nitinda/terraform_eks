# resource "kubernetes_ingress" "demo-kubernetes-ingress-nginx" {
#   metadata {
#     name = "terraform-demp-kubernetes-ingress-nginx"
#     namespace = "${kubernetes_namespace.demo-kubernetes-namespace-nginx.metadata.0.name}"
#   }  

#   spec {
#     backend {
#       service_name = "${kubernetes_pod.demo-kubernetes-pod-nginx.metadata.0.labels.app}"
#       service_port = 8080
#     }

#     rule {
#       http {
#         path {
#           backend {
#             service_name = "${kubernetes_pod.demo-kubernetes-pod-nginx.metadata.0.labels.app}"
#             service_port = 80
#           }
#           path = "/"
#         }
#       }
#     }

#     tls {
#       secret_name = "tls-secret"
#     }
#   }
# }