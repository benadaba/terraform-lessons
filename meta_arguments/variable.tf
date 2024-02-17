variable "my-current-region" {
  type        = string
  description = "This is the region i want to provision my infrastructure in"
  default     = "eu-west-2"
}

variable "name"{
  type = string
  description = "bucket name"
  default = "dpbk"
}


variable "create_bucket"{
  type = bool
  description = "confirm whether or not you want to create an s3 bucket"
  default = true
}

variable "num-of-bkts"{
  type =number
  default = 4
}

variable buckets-suffixes{
   type = list(string)
  #  default = ["s0","s1","s2","s3","s4","s5"]
  default = []
}