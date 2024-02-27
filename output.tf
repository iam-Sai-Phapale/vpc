output "public-ip" {
    description = "this is public ip"
    value =  aws_instance.web.public_ip 
}

output "private-ip" {
    description = "this is public ip"
    value =  aws_instance.web.private_ip 
}