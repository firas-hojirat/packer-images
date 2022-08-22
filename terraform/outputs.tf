output "public_ip" {
  value = aws_instance.pyautomation.public_ip
}

output "admin_password" {
  value = aws_instance.pyautomation.password_data
}