resource "aws_s3_bucket" "example" {
  bucket = "tfstate-bucket-datapandas1"
  acl = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "My terraform state bucket"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "example" {
  name             = "terraform-lock"
  hash_key         = "LockID"
  read_capacity = 3
  write_capacity = 3

  attribute {
    name = "LockID"
    type = "S"
  }

  tags =  {
    Name = "Table for terraform state locking"
  }
}