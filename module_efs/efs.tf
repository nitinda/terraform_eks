resource "aws_efs_file_system" "demo-efs-eks" {
  creation_token = "terraform-demo-efs-eks"
  tags = "${
    map(
     "Name", "terraform-demo-efs-eks",
     "kubernetes.io/cluster/${var.cluster-name}", "owned",
     "Project", "${local.Project}",
     "Owner", "${local.Owner}",
     "Environment", "${local.Environment}",
     "BusinessUnit", "${local.BusinessUnit}"
    )
  }"
}

resource "aws_efs_mount_target" "demo-efs-mount-targets-eks" {
  # count          = "${length("${aws_subnet.demo-subnet-private.*.id}")}"
  count          = 2
  file_system_id = "${aws_efs_file_system.demo-efs-eks.id}"
  subnet_id      = "${var.web_subnet_ids[count.index]}"
  security_groups = ["${aws_security_group.demo-security-group-efs.id}"]
}