output "public_ip"{
    value ="ssh -i datapandas-devops-keypair.pem ${var.user}@${aws_instance.illustrate-remote-exec.public_ip}"
}