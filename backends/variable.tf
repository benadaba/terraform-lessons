variable my-current-region{
  type = string
  description = "This is the region i want to provision my infrastructure in"
  default = "eu-west-2"
}

variable my-vpc-cidr {
  type = string
  description = "this is my vpcs cidr range"
  default = "10.0.0.0/16"
}

variable user {
  type = string
  description = "this is my vpcs cidr range"
  default = "ubuntu"
}

variable my-ami {
  type = string
  description = "my ami"
  # default = "ami-01450e8988a4e7f44" # us-east-2
  default = "ami-093cb9fb2d34920ad" # london -region 
}

variable instance-type-for-region{
  type = string
  description = "the instance we want to use"
  default = "t2.micro"
}

variable default-key-pair{
  type = string
  description = "my keypair"
  default = "datapandas-devops-keypair"
}
