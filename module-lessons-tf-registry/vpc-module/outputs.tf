output "vpc-id-our-own-name"{
    description = "the id of the vpc that was created using terraform registry module"
    value = module.vpc.vpc_id
}

output "private-sub-arns-our-own-name"{
    description = "goes here"
    value = module.vpc.private_subnet_arns
}


output "public_subnets"{
    value = module.vpc.public_subnets
}