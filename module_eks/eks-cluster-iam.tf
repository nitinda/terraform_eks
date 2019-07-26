resource "aws_iam_role" "demo-iam-role-eks-cluster" {
  name = "terraform-demo-iam-role-eks-cluster"
  tags = "${var.common_tags}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-attachment-eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.demo-iam-role-eks-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-attachment-eks-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.demo-iam-role-eks-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-attachment-eks-cluster-AmazonEC2ReadOnlyAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  role       = "${aws_iam_role.demo-iam-role-eks-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-attachment-eks-cluster-AmazonEC2FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = "${aws_iam_role.demo-iam-role-eks-cluster.name}"
}
