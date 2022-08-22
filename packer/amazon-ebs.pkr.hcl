
variable "aws_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# This example uses a amazon-ami data source rather than a specific AMI.
# this allows us to use the same filter regardless of what region we're in,
# among other benefits.
data "amazon-ami" "windows-2022" {
  filters = {
    virtualization-type = "hvm"
    name                = "*Windows_Server-2022-English-Full-Base*"
    root-device-type    = "ebs"
  }
  owners      = ["801119661308"]
  most_recent = true
  # Access Region Configuration
  region = var.aws_region
}

source "amazon-ebs" "windows" {
  source_ami    = data.amazon-ami["${local.os_type}-${local.os_version}"].id
  instance_type = var.aws_instance_type
  region        = var.aws_region
  ami_name      = local.image_name
  # This user data file sets up winrm and configures it so that the connection
  # from Packer is allowed. Without this file being set, Packer will not
  # connect to the instance.
  #
  user_data = templatefile("${path.root}/scripts/bootstrap_win.pkrtpl.hcl", {
    winrm_username = local.winrm_username,
    winrm_password = local.winrm_password
  })
  # user_data_file = "${path.root}/scripts/bootstrap_win.txt"
  communicator   = "winrm"
  winrm_username = local.winrm_username
  winrm_password = local.winrm_password
  winrm_use_ssl    = true
  winrm_insecure   = true
  force_deregister = true
}