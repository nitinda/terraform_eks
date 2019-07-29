resource "aws_security_group" "demo-security-group-eks-worker-node" {
  name        = "terraform-demo-eks-security-group-worker-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${var.vpc_id}"
  revoke_rules_on_delete = true

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-eks-security-group-worker-node",
    "kubernetes.io/cluster/${var.cluster-name}", "owned",
  ))}"
}

resource "aws_security_group_rule" "demo-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.demo-security-group-eks-worker-node.id}"
  source_security_group_id = "${aws_security_group.demo-security-group-eks-worker-node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "demo-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.demo-security-group-eks-worker-node.id}"
  source_security_group_id = "${aws_security_group.demo-security-group-eks-cluster.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "demo-node-ingress-worker-node-443" {
  description              = "Allow pods running extension API servers on port 443 to receive communication from cluster control plane"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.demo-security-group-eks-worker-node.id}"
  source_security_group_id = "${aws_security_group.demo-security-group-eks-cluster.id}"
  to_port                  = 443
  type                     = "ingress"
}
