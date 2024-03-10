output "public_ip"{
    value ="ssh -i datapandas-devops-keypair.pem ${var.user}@${aws_instance.my-dp-local-ec2-name.public_ip}"
}