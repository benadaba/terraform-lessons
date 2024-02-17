variable "my-current-region" {
  type        = string
  description = "This is the region i want to provision my infrastructure in"
  default     = "us-east-1"
}

variable "my-vpc-cidr" {
  type        = string
  description = "this is my vpcs cidr range"
  default     = "10.0.0.0/16"
}

variable "pub-sub1-cidr"{
   type        = string
    description = "this is my ps1 cidr range"
    default     = "10.0.1.0/24"
}



variable "instance-type-for-region"{
   type        = string
    description = "this is my ps1 cidr range"
    default     = "t2.micro"
}

variable "default-key-pair"{
   type        = string
    description = "this is my ps1 cidr range"
    default     = "10.0.1.0/24"
}

variable "ingress_ports_map" {
  description = "port numbers for security group"
  type = map(number)
  default = {
     "http" = 80,
     "jenkins" = 8080, 
     "https" = 443, 
     "ssh" = 22, 
     "all" = 0, 
     "rds" = 3306
     "sonar" = 9000
     }
}


#list datatype. var.ingress_ports[1]
variable "ingress_ports" {
  description = "port numbers for security group"
  type = list(number)
  default = [80,8080, 443, 22, 0, 3306]
}


variable public_cidrs_list{
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
  # default = []
}