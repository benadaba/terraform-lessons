locals {
  tags = {
    vpc       = "tf-vpc-creation",
    pub-sub-1 = "public_subnet-1-tf",
    pub-sub-2 = "public_subnet-2-tf"
  }
    
  ec2_tag_Name = "${var.my-current-region}-my-ec2"
  vpc_tag_Name = "vpc_created_with_tf-${random_integer.priority.result}-${data.aws_region.current.name}"
  

}


resource "random_integer" "priority" {
  min = 1
  max = 10
}
