resource "aws_kms_alias" "demo-kms-alias-ebs-voulme" {
  name          = "alias/terraform-demo-eks-ebs-volume"
  target_key_id = "${aws_kms_key.demo-kms-key-ebs-volume.key_id}"
}