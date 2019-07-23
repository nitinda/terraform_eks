resource "aws_security_group" "demo-security-group-efs" {
  name        = "terraform-demo-eks-security-efs"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${var.vpc_id}"
  revoke_rules_on_delete = true

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"
    cidr_blocks = ["${var.web_subnet_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "terraform-demo-eks-security-group-worker-node",
     "kubernetes.io/cluster/${var.cluster-name}", "owned",
     "Project", "${local.Project}",
     "Owner", "${local.Owner}",
     "Environment", "${local.Environment}",
     "BusinessUnit", "${local.BusinessUnit}"
    )
  }"
}