#settings block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#Provider block
provider "aws" {
  # Configuration options
  region = var.my-current-region
}