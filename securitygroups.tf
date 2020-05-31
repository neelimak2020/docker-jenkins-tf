resource "aws_security_group" "ecs_securitygroup" {
  vpc_id      = aws_vpc.ecs_vpc.id
  name        = "ecs"
  description = "security group for ecs"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 31000
    to_port         = 61000
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_elb_securitygroups.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = [var.ECS_PUBLIC_CIDR]
  }

  tags = {
    Name = "ecs"
  }
}

resource "aws_security_group" "ecs_elb_securitygroups" {
  vpc_id      = aws_vpc.ecs_vpc.id
  name        = "ecs_elb"
  description = "security group for ecs elb"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-elb"
  }
}





