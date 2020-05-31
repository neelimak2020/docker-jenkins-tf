#Internet VPC

resource "aws_vpc" "ecs_vpc" {
  cidr_block           = "${var.VPC_CIDR}"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    name = var.VPC_TAGS
  }
}
resource "aws_internet_gateway" ecs_ig {
  vpc_id = aws_vpc.ecs_vpc.id

  tags = {
    Name = "ecs_ig"
  }
}

resource "aws_subnet" "ecs_public_sb" {
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = var.ECS_PUBLIC_CIDR
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "ecs_public_sn"
  }
}

resource "aws_subnet" "ecs_private_sb" {
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = var.ECS_PRIVATE_CIDR
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "ecs_private_sn"
  }
}

resource "aws_route_table" "ecs_public_rt" {

  vpc_id = aws_vpc.ecs_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs_ig.id
  }

  tags = {
    Name = "ecs-public-route"
  }
}

resource "aws_route_table_association" "ecs_public_rt_asso" {
  subnet_id      = aws_subnet.ecs_public_sb.id
  route_table_id = aws_route_table.ecs_public_rt.id
}

resource "aws_route_table" "ecs_private_rt" {
  vpc_id = aws_vpc.ecs_vpc.id
}

resource "aws_route_table_association" "ecs_private_rt_asso" {
  subnet_id      = aws_subnet.ecs_private_sb.id
  route_table_id = aws_route_table.ecs_private_rt.id
}




