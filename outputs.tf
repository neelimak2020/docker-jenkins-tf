output "region" {
  value = var.AWS_REGION
}

output "ecs_vpc_id" {
  value = aws_vpc.ecs_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.ecs_public_sb.id 
}

output "security_group_id" {
  value = aws_security_group.ecs_securitygroup.id
}

output "ecs-service-role-arn" {
  value = aws_iam_role.ecs_service_role.arn
}

output "ecs-instance-role-name" {
  value = aws_iam_role.ecs_instance_role.name
}

output "ecs-load-balancer-name" {
    value = aws_elb.ecs-load-balancer.name
}

