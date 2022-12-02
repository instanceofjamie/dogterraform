resource "aws_autoscaling_group" "web" {
  name = "${aws_launch_configuration.web.name}-asg"
  min_size             = 1
  desired_capacity     = 1
  max_size             = 2
  force_delete         = true
  target_group_arns    = ["${aws_lb_target_group.web-tg.arn}"]
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.web.name}"
  vpc_zone_identifier  = [
    "${aws_subnet.techtest_public_subnet[0].id}",
    "${aws_subnet.techtest_public_subnet[1].id}",
    "${aws_subnet.techtest_public_subnet[2].id}"
  ]
  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}

resource "aws_lb_target_group" "web-tg" {
  name     = "techtest-targetgroup"
  depends_on = [aws_vpc.techtest_vpc]
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.techtest_vpc.id}"
  health_check {
    interval            = 70
    path                = "/"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60 
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}