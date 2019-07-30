output "kms_key_ebs_volume_arn" {
  value = "${aws_kms_key.demo-kms-key-ebs-volume.arn}"
}