output "s3-bucket-name" {
  value =  aws_s3_bucket.s3[*].bucket
}


output "s3-bucket-arn-for-each" {
  value =  [ for bkt in aws_s3_bucket.s3 : bkt.arn ]
}




output "s3-bucket-reginal-dom-name" {
#   value =  aws_s3_bucket.s3[*].bucket_regional_domain_name
value =  [ for bkt in aws_s3_bucket.s3 : bkt.bucket_regional_domain_name ]
}
# bucket_regional_domain_name

