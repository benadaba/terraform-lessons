resource "aws_s3_bucket" "s3" {
  count = var.create_bucket ? length(var.buckets-suffixes) : 0 #tenary operator
  bucket = "dp-bucket-${random_integer.bucket-number.result}-${var.name}-${count.index}"

  tags = {
    Name        = "My bucket-${count.index}"
    Environment = "Dev-${count.index}"
  }
}


resource "aws_s3_bucket_public_access_block" "example" {
#   bucket = aws_s3_bucket.s3[0].id # create block access for bucket at index 0
  count = var.create_bucket && length(var.buckets-suffixes) > 0 ? length(var.buckets-suffixes) : 0
  bucket = aws_s3_bucket.s3[count.index].id # create block access for bucket at index 0
#   bucket = aws_s3_bucket.s3[*].id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_versioning" "s3_versioning" {
#   bucket = aws_s3_bucket.s3[1].id
  count = var.create_bucket ? length(var.buckets-suffixes) : 0
  # bucket = aws_s3_bucket.s3[count.index].id
  bucket = element(aws_s3_bucket.s3[*].id, count.index)
  versioning_configuration {
    status = "Enabled"
  }
}

resource "random_integer" "bucket-number" {
  min = 1
  max = 50000
}
