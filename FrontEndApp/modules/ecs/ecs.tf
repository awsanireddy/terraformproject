data "aws_iam_policy" "ecs_task_execution_role" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_cluster" "ecs-name" {
   name = "${var.namespace}-ecs-cluster"
 }

 resource "aws_ecs_service" "ecs_service" {
  name            = "${var.namespace}-${var.service_name}"
  cluster         = aws_ecs_cluster.ecs-name.name
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 0
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = var.
    container_name   = "ui"
    container_port   = "6000"
  }

  network_configuration {
    subnets             = flatten([var.private_subnet_id_list])
    assign_public_ip    = false
    security_groups     = [var.security_group_id_1]
  }

  lifecycle {
    ignore_changes = [desired_count, health_check_grace_period_seconds, task_definition]
  }

  data "template_file" "task_definition_template" {
  template = file("${path.module}/files/task-definition.json.tpl")
}

resource "aws_iam_role" "ui-task-execution-role" {
  name               = "${var.namespace}-ui-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
  resource "aws_ecs_task_definition" "task_definition" {
    family                = "${var.namespace}-${var.service_name}"
    execution_role_arn = aws_iam_role.ui-task-execution-role.arn
    container_definitions = data.template_file.task_definition_template.rendered
    requires_compatibilities = ["FARGATE"]
    lifecycle {
      ignore_changes = [container_definitions]
    }
    cpu                   = var.task_cpu
    memory                = var.task_memory
    network_mode          = "awsvpc"
  }

  resource "aws_cloudwatch_log_group" "service_cloudwatch_log_group" {
    name = "/ecs/${var.namespace}-${var.service_name}"
    retention_in_days = 60
  }
