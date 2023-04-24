resource "aws_launch_template" "template" {
  name_prefix   = var.tp_name_prefix
  image_id      = var.tp_image_id
  instance_type = var.tp_instance_type
  tags = {
    Name = "${var.tp_name_prefix}"
  }
}

resource "aws_autoscaling_group" "asg_complete" {
  capacity_rebalance        = var.asg_capacity_rebalance
  desired_capacity          = var.asg_desired_capacity
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = var.asg_health_check_grace_period
  health_check_type         = var.asg_health_check_type
  vpc_zone_identifier       = var.asg_vpc_zone
  
  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = var.asg_on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.asg_on_demand_percentage_above_base_capacity
      spot_allocation_strategy                 = var.asg_spot_allocation_strategy
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.template.id
        version = "$Latest"
      }
      override {
        instance_type     = "t2.micro"
        weighted_capacity = "3"
      }
    }  
  }
 tag {
   key = "Name"
   value = "My-Auto-scaling-group"
   propagate_at_launch = true
 }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.asg_complete.id
  lb_target_group_arn    = var.target_group_arn
}

#scaling policy
resource "aws_autoscaling_policy" "scal_policy" {
  name = var.scal_po_name 
  autoscaling_group_name = aws_autoscaling_group.asg_complete.name
  policy_type = "TargetTrackingScaling"
  estimated_instance_warmup = var.warm_up
  target_tracking_configuration {
    target_value = var.target_val
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}