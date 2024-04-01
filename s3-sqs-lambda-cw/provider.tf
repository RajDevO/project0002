terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


provider "aws" {
  alias  = "source_acc"
  region = var.aws_region_s3 # s3 region
  assume_role {
    role_arn = var.aws_iam_role_s3
  }
}


provider "aws" {
  alias  = "destination_acc"
  region = var.aws_region_sqs # sqs region
  assume_role {
    role_arn = var.aws_iam_role_sqs
  }
}