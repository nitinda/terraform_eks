

data "aws_ami" "demo-ami-eks-worker-node" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.demo-eks-cluster.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

data "template_file" "demo-eks-asg-userdata" {
  template = "${file("${path.module}/../module_eks/files/worker_nodes_userdata.sh")}"

  vars {
    EKS_CLUSTER_NAME = "${var.cluster-name}"
    EKS_ENDPOINT     = "${aws_eks_cluster.demo-eks-cluster.endpoint}"
    EKS_CA           = "${aws_eks_cluster.demo-eks-cluster.certificate_authority.0.data}"
    EFS_ENDPOINT     = "${join(" ", "${var.efs_mount_target_ip_address}")}"
  }
}

resource "aws_launch_template" "demo-lt-eks-worker-node" {
  name_prefix   = "terraform-demo-lc-eks-worker-node-"
  description   = "This is lc template for eks worker nodes"
  image_id      = "${data.aws_ami.demo-ami-eks-worker-node.id}"
  instance_type = "t3.small"
  ebs_optimized = false

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      delete_on_termination = true
      volume_type = "gp2"
    }
  }

  iam_instance_profile = {
    name = "${aws_iam_instance_profile.demo-iam-instance-profile-worker-node.name}"
  }
  
  vpc_security_group_ids = ["${aws_security_group.demo-security-group-eks-worker-node.id}"]

  monitoring {
    enabled = false
  }
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "terraform-demo-lt-eks-worker-node-ec2"
      Project = "${local.Project}"
      Owner = "${local.Owner}"
      Environment = "${local.Environment}"
      BusinessUnit = "${local.BusinessUnit}"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = "terraform-demo-lt-eks-worker-node-ec2"
      Project = "${local.Project}"
      Owner = "${local.Owner}"
      Environment = "${local.Environment}"
      BusinessUnit = "${local.BusinessUnit}"
    }
  }

  user_data = "${base64encode("${data.template_file.demo-eks-asg-userdata.rendered}")}"
}
