#CLUSTER

resource "aws_ecs_cluster" "nginx_cluster" {
name="nginx_cluster"
}

#ECS LAUNCH CONFIGURATION

resource "aws_launch_configuration" "ecs_nginx_launchconfig"{
name_prefix="ecs_launch_config"
image_id=var.ECS_AMIS[var.AWS_REGION]
instance_type=var.ECS_INSTANCE_TYPE
key_name=var.ECS_KEY
iam_instance_profile=aws_iam_instance_profile.ecs_instance_profile.id
security_groups= [aws_security_group.ecs_securitygroup.id]
associate_public_ip_address = "true"

root_block_device{
volume_type="standard"
volume_size=100
delete_on_termination=true
}

user_data= <<EOF
#!/bin/bash
echo 'ECS_CLUSTER=nginx_cluster' >> /etc/ecs/ecs.config
start ecs
EOF

lifecycle{
create_before_destroy=true
}
}

# AUTO SCALING GROUP

resource "aws_autoscaling_group" "ecs_nginx_autoscaling"{
name ="ecs_nginx_autoscaling"
vpc_zone_identifier  = [aws_subnet.ecs_public_sb.id]
launch_configuration = aws_launch_configuration.ecs_nginx_launchconfig.name

min_size=var.MIN_INSTANCE_SIZE
max_size=var.MAX_INSTANCE_SIZE
desired_capacity=var.DESIRED_CAPACITY
health_check_type="ELB"

tag{
key ="Name"
value="ecs-ec2-container"
propagate_at_launch=true
}
}







