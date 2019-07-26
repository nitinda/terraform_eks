output "efs_mount_target_ids" {
  value = "${aws_efs_mount_target.demo-efs-mount-targets-eks.*.id}"
}

output "efs_mount_target_ip_address" {
  value = "${aws_efs_mount_target.demo-efs-mount-targets-eks.*.ip_address}"
}

output "efs_dns_name" {
  value = "${aws_efs_file_system.demo-efs-eks.dns_name}"
}

output "efs_id" {
  value = "${aws_efs_file_system.demo-efs-eks.id}"
}
