resource "aws_launch_template" "eks_node_launch_template" {
  name_prefix   = "eks-node-launch-template"
  image_id      = "ami-0866a3c8686eaeeba"
  instance_type = "t2.medium"

  key_name = "eni-master"

  network_interfaces {
    associate_public_ip_address = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = "eks-node"
    }
  }
}

resource "aws_autoscaling_group" "node_group" {
  min_size             = 2
  max_size             = 5
  desired_capacity     = 2
  vpc_zone_identifier  = [aws_subnet.kb_subnet_2a.id, aws_subnet.kb_subnet_2b.id, aws_subnet.kb_subnet_2c.id]

  launch_template {
    id      = aws_launch_template.eks_node_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "eks-node"
    propagate_at_launch = true
  }
}