output "public_ip_addres" {
    value = aws_instance.terraform.public_ip
}
output "private_ip_addres" {
    value = aws_instance.terraform.private_ip
}
output "server_arn" {
    value = aws_instance.terraform.arn
}


output "public_ip_addres" {
    value = aws_instance.terraform_2.public_ip
}
output "private_ip_addres" {
    value = aws_instance.terraform_2.private_ip
}
output "server_arn" {
    value = aws_instance.terraform_2.arn
}