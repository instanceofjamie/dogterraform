resource "aws_alb" "web_elb" {
  name = "web-elb"
  load_balancer_type = "application"
  security_groups = [
    "${aws_security_group.techtest_elb_sg.id}"
  ]
  subnets = [
    "${aws_subnet.techtest_public_subnet[0].id}",
    "${aws_subnet.techtest_public_subnet[1].id}",
    "${aws_subnet.techtest_public_subnet[2].id}"
  ]
  internal = false
}

resource "aws_lb_listener" "web_elb_listener" {
    load_balancer_arn   = aws_alb.web_elb.arn
    port                = "80"
    protocol            = "HTTP"
    default_action {
        type    = "forward"
        target_group_arn = aws_lb_target_group.web-tg.arn
    }
}