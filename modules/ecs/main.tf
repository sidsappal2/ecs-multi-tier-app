
resource "aws_ecs_cluster" "this" {
  name = "multi-tier-cluster"
}

resource "aws_ecs_task_definition" "frontend" {
  family                   = "frontend-task"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = var.ecs_task_execution_role_arn
  container_definitions   = file("${path.module}/frontend-container.json")
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "backend-task"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "512"
  memory                  = "1024"
  execution_role_arn      = var.ecs_task_execution_role_arn
  container_definitions   = file("${path.module}/backend-container.json")
}
