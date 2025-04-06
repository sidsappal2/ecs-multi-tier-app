
provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}

module "ecs" {
  source                     = "./modules/ecs"
  vpc_id                     = module.vpc.vpc_id
  public_subnets             = module.vpc.public_subnets
  private_subnets            = module.vpc.private_subnets
  ecs_task_execution_role_arn = module.iam.ecs_execution_role_arn
}

module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnets
  target_group_arn   = module.ecs.backend_target_group_arn
}

module "rds" {
  source     = "./modules/rds"
  db_subnets = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id
}
