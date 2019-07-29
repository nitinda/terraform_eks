resource "aws_autoscaling_group" "demo-autoscaling-group-eks-worker-node" {
  desired_capacity     = 2
  max_size             = 2
  min_size             = 1
  name                 = "terraform-demo-autoscaling-group-eks-worker-node"
  vpc_zone_identifier  = ["${var.web_subnet_ids}"]
  health_check_grace_period = 2
  default_cooldown = 1
  
  tag {
    key                 = "Name"
    value               = "terraform-demo-ec2-eks-worker-node"
    propagate_at_launch = true
  }

  tag {
    key                 = "Owner"
    value               = "${lookup(var.common_tags, "Owner")}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "${lookup(var.common_tags, "Project")}"
    propagate_at_launch = true
  }

  tag {
    key                 = "BusinessUnit"
    value               = "${lookup(var.common_tags, "BusinessUnit")}"
    propagate_at_launch = true
  }

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = "${aws_launch_template.demo-lt-eks-worker-node.id}"
        version = "$$Latest"
      }

      override {
        instance_type = "t3.xlarge"
      }

      override {
        instance_type = "t3.2xlarge"
      }
    }
    instances_distribution {
      on_demand_allocation_strategy = "prioritized"
      on_demand_base_capacity = 0
      on_demand_percentage_above_base_capacity = 0
      spot_allocation_strategy = "lowest-price"
      spot_instance_pools = 2
    }
  }
}