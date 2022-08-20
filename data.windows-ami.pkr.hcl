# Data sources are always treated BEFORE locals and sources.
data "amazon-ami" "windows-2022" {
  filters = {
    name                = "Windows_Server-2022-English-Core-ContainersLatest-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["amazon"]
  region      = var.aws_region
}
