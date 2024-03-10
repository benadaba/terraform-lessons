#settings block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"  
    }
  }

  backend "s3"{
    bucket = "tfstate-bucket-datapandas1"
    key = "terraform/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region = "eu-west-2"
  }
}

#Provider block
provider "aws" {
  # Configuration options
  region = var.my-current-region
}