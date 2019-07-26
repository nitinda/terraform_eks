# resource "kubernetes_pod" "demo-kubernetes-pod-nginx" {
#     metadata {
#         name = "terraform-demo-kubernetes-pod-nginx"
#         labels {
#             app = "nginx"
#         }
#         namespace = "${kubernetes_namespace.demo-kubernetes-namespace-nginx.metadata.0.name}"
#     }
#     spec {
#         container {
#             image = "nginx:1.7.9"
#             name  = "terraform-demo-kubernetes-pod-container-nginx"
#             port {
#                 container_port = 80
#                 host_port = 8080
#             }
#         }        
#     }
# }