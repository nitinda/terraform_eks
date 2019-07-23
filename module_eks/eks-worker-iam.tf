resource "aws_iam_role" "demo-iam-role-worker-node" {
  name = "terraform-demo-iam-role-eks-worker-node"
  tags = "${local.common_tags}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-attachment-eks-worker-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.demo-iam-role-worker-node.name}"
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-attachment-eks-worker-node-AmazonEKSCNIPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.demo-iam-role-worker-node.name}"
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-attachment-eks-worker-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.demo-iam-role-worker-node.name}"
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-attachment-eks-worker-node-AmazonEC2RoleforSSM" {
  role       = "${aws_iam_role.demo-iam-role-worker-node.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonSSMAutomationRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole"
  role       = "${aws_iam_role.demo-iam-role-worker-node.name}"
}

resource "aws_iam_instance_profile" "demo-iam-instance-profile-worker-node" {
  name = "terraform-demo-instane-profile-eks-worker-node"
  role = "${aws_iam_role.demo-iam-role-worker-node.name}"
}

resource "aws_iam_role_policy" "demo-iam-role-poicy-worker-node" {
  name = "terraform-demo-iam-role-policy-eks-worker-node"
  role = "${aws_iam_role.demo-iam-role-worker-node.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey",
                "kms:CreateGrant"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowEC2",
            "Effect": "Allow",
            "Action": [
                "ec2:*Volume*",
                "ec2:*Snapshot*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
