terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.48.0"
    }
  }

  backend "s3" {
    bucket = "vijay-remote-state"
    key    = "super-mario"
    dynamodb_table = "vijay-remotestate-lock"
  }
}

#provide authentication here
provider "aws" {
  region = "us-east-1"
}


 
