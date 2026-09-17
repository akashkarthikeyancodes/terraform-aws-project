terraform {
  backend "s3" {
    bucket       = "terraform-aws-project-akash-state"
    key          = "terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}