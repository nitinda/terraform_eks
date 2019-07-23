resource "aws_autoscaling_group" "demo-autoscaling-group-eks-worker-node" {
  desired_capacity     = 1
  max_size             = 1
  min_size             = 1
  name                 = "terraform-demo-autoscaling-group-eks-worker-node"
  vpc_zone_identifier  = ["${var.web_subnet_ids}"]
  health_check_grace_period = 5
  default_cooldown = 1
  
  launch_template {
    id      = "${aws_launch_template.demo-lt-eks-worker-node.id}"
    version = "$$Latest"
  }

  tag {
    key                 = "Name"
    value               = "terraform-demo-ec2-eks-worker-node"
    propagate_at_launch = true
  }

  tag {
    key                 = "Owner"
    value               = "${local.Owner}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "${local.Project}"
    propagate_at_launch = true
  }

  tag {
    key                 = "BusinessUnit"
    value               = "${local.BusinessUnit}"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }

  tag{
    key = "KubernetesCluster"
    value = "${var.cluster-name}"
    propagate_at_launch = true
  }
}