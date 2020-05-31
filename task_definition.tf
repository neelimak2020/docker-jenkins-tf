data "template_file" "nginx_task_defination_template"{
template=file("templates/nginx.json.tp1")
}

resource "aws_ecs_task_definition" "nginx_task_defination"{
family="nginxapp"
container_definitions = data.template_file.nginx_task_defination_template.rendered
}


