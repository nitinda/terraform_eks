resource "kubernetes_config_map" "demo-kubernetes-config-map-efs-provisioner" {
  metadata {
    name = "config-map-efs-provisioner"
    # namespace = "${kubernetes_namespace.demo-kubernetes-namespace.metadata.0.name}"

    # labels {
    #   name = "terraform-demo-kubernetes-config-map-efs-provisioner-label"
    # }
  }
  
  data = {
    file.system.id = "${var.efs_id}"
    aws.region = "${data.aws_region.demo-current.name}"
    provisioner.name = "${var.efs_provisioner}"
    dns.name = "${var.efs_id}.efs.${data.aws_region.demo-current.name}.amazonaws.com"
  }
}