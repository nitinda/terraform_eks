resource "aws_security_group" "demo-security-group-eks-cluster" {
  name        = "terraform-demo-eks-security-group-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${var.vpc_id}"
  revoke_rules_on_delete = true

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-demo-eks-security-group-cluster"
    Project = "${local.Project}"
    Owner = "${local.Owner}"
    Environment = "${local.Environment}"
    BusinessUnit = "${local.BusinessUnit}"
  }
}

resource "aws_security_group_rule" "demo-security-group-rule-cluster-ingress-workstation-https" {
  description              = "Allow workstation to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.demo-security-group-eks-cluster.id}"
  cidr_blocks              = ["${local.workstation-external-cidr}","${var.vpc_cidr}"]
  to_port                  = 443
  type                     = "ingress"
}
