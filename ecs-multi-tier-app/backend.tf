
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "ecs/multi-tier-app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
