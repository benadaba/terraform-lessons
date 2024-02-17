module "my-ec2-infra"{
    source = "../module-lessons/ec2-folder"
}

module "m-arguments"{
    source = "../intro_and_other_infra"
}


module "other-infra"{
    source = "../meta_arguments"
}

