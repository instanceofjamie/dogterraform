resource "aws_launch_configuration" "web" {
  name_prefix = "web-"
  image_id = "ami-05bfd03d0709e3ecb" 
  instance_type = "t2.micro"
  key_name = "techtest_kp"
  security_groups = [ "${aws_security_group.techtest_elb_sg.id}" ]
  associate_public_ip_address = true
  user_data = "${file("data.sh")}"
  lifecycle {
    create_before_destroy = true
  }
}