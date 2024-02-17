#settings block
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.20"
    }
  }
}

#Provider block
provider "aws" {
  # Configuration options
  region = "us-east-1"
}