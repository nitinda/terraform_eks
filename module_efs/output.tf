output "efs_mount_target_ids" {
  value = "${aws_efs_mount_target.demo-efs-mount-targets-eks.*.id}"
}

output "efs_mount_target_ip_address" {
  value = "${aws_efs_mount_target.demo-efs-mount-targets-eks.*.ip_address}"
}
