locals {
  aws_instance_type = {
    "amd64" = "t2.micro"  # 2 CPU / 8 GB / $0.0835 - https://aws.amazon.com/fr/ec2/instance-types/t3/#Product_Details
  }
  windows_winrm_user = {
    "amazon-ebs" = "Administrator" # In AWS EC2, WinRM super admin must be the "Administrator" account
  }
  windows_disk_size_gb = 128 # Must be greater than 127 Gb to allow Azure template to work with
}
