resource "aws_ecs_service" "myapp-service" {
   name            = "ngnix_tf_app"
  cluster         = aws_ecs_cluster.nginx_cluster.id
  task_definition = aws_ecs_task_definition.nginx_task_defination.arn
  desired_count   = 1
 # iam_role        = aws_iam_role.ecs_service_role.arn
  depends_on      = [aws_iam_role_policy_attachment.ecs_service_role_attachment]

 # load_balancer {
 #   elb_name       = aws_elb.ecs-load-balancer.name
 #  container_name = "nginx"
 #   container_port = 3000
 # }
  lifecycle {
    ignore_changes = [task_definition]
  }
}

