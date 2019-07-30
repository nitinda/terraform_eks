resource "kubernetes_storage_class" "demo-kubernetes-storage-class-ebs-provisioner" {
  metadata {
    name = "terraform-demo-kubernetes-storageclass-aws-ebs-provisioner"
    labels {
        app = "ebs-provisioner-storage-class"
        # "addonmanager.kubernetes.io/mode" = "EnsureExists"
    }
    annotations {
      "storageclass.kubernetes.io/is-default-class" = "false"
    }
  }
  storage_provisioner = "${var.ebs_provisioner}"
  parameters = {
    type = "gp2"
    fsType = "ext4"
    encrypted = true
    kmsKeyId = "${var.kms_key_id}"
  }
  allow_volume_expansion = true
}