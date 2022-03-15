# create a security group for ALB
resource "aws_security_group" "alb_sg" {
  name   = "${var.name_prefix}-ALB-SG"
  vpc_id = var.vpc_id

  # inbound rule allows all traffic form port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create a security group for launch template
resource "aws_security_group" "template_sg" {
  name   = "${var.name_prefix}-template"
  vpc_id = var.vpc_id

  ingress {
    # allow any traffic from the ALB
    security_groups = [aws_security_group.alb_sg.id]
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}