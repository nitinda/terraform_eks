resource "aws_eks_cluster" "demo-eks-cluster" {
  name            = "${var.cluster-name}"
  role_arn        = "${aws_iam_role.demo-iam-role-eks-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.demo-security-group-eks-cluster.id}"]
    subnet_ids         = ["${var.public_subnet_ids}"]
    endpoint_public_access  = true
    endpoint_private_access = true
  }

  depends_on = [
    "aws_iam_role_policy_attachment.demo-iam-role-policy-attachment-eks-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.demo-iam-role-policy-attachment-eks-cluster-AmazonEKSServicePolicy",
  ]
}