# # ## Worker Node AutoScaling Group

# data "aws_ami" "demo-ami-eks-worker-node" {
#   filter {
#     name   = "name"
#     values = ["amazon-eks-node-${aws_eks_cluster.demo-eks-cluster.version}-v*"]
#   }

#   most_recent = true
#   owners      = ["602401143452"] # Amazon EKS AMI Account ID
# }


# data "template_file" "demo-eks-asg-userdata" {
#   template = "${file("../module/files/userdata.sh")}"

#   vars {
#     EKS_CLUSTER_NAME = "${var.cluster-name}"
#     EKS_ENDPOINT     = "${aws_eks_cluster.demo-eks-cluster.endpoint}"
#     EKS_CA           = "${aws_eks_cluster.demo-eks-cluster.certificate_authority.0.data}"
#     EFS_ENDPOINT     = "${join(" ", "${aws_efs_mount_target.demo-efs-mount-targets-eks.*.ip_address}")}"
#   }
# }


# # # This data source is included for ease of sample architecture deployment
# # # and can be swapped out as necessary.
# # data "aws_region" "current" {}

# # # EKS currently documents this required userdata for EKS worker nodes to
# # # properly configure Kubernetes applications on the EC2 instance.
# # # We utilize a Terraform local here to simplify Base64 encoding this
# # # information into the AutoScaling Launch Configuration.
# # # More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html

# locals {
#   demo-node-userdata = <<USERDATA
# #!/bin/bash
# set -o xtrace
# /etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.demo-eks-cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.demo-eks-cluster.certificate_authority.0.data}' '${var.cluster-name}'
# yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
# sudo yum install -y nfs-utils
# USERDATA
# }

# resource "aws_launch_configuration" "demo-lc-eks-worker-node" {
#   associate_public_ip_address = false
#   iam_instance_profile        = "${aws_iam_instance_profile.demo-iam-instance-profile-worker-node.name}"
#   image_id                    = "${data.aws_ami.demo-ami-eks-worker-node.id}"
#   instance_type               = "t3.small"
#   name_prefix                 = "terraform-demo-lc-eks-worker-node"
#   security_groups             = ["${aws_security_group.demo-security-group-eks-worker-node.id}"]
#   user_data                   = "${data.template_file.demo-eks-asg-userdata.rendered}"
#   ebs_optimized               = true
#   enable_monitoring           = false

#   lifecycle {
#     create_before_destroy = true
#   }
  
#   root_block_device {
#     volume_type = "gp2"
#     volume_size = 20
#     delete_on_termination = true
#   }
#   # key_name = "nitinda-aws-first-account"
# }