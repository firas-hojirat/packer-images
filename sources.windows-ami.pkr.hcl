# This source defines all the common settings for any AWS AMI (whatever Operating System)
source "amazon-ebs" "base" {
  ami_name      = "${local.image_name}-${var.architecture}-${local.now_unix_timestamp}"
  instance_type = local.aws_instance_type[var.architecture]

  # Define custom rootfs for build to avoid later filesystem extension during agent startups
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = local.windows_disk_size_gb
    volume_type           = "gp2"
  }

  # Where to build the VM
  region = var.aws_region

  # Where to export the AMI
  ami_regions = [
    var.aws_region
  ]

  # Egg-and-chicken: what is the base image to start from (eg. what is my egg)?
  source_ami = data.amazon-ami["${var.agent_os_type}-${local.agent_os_version_safe}"].id

  # To improve audit and garbage collecting, we provide tags
  tags = {
    imageplatform = var.architecture
    imagetype     = local.image_name
    timestamp     = local.now_unix_timestamp
    version       = var.image_version
    scm_ref       = var.scm_ref
    build_type    = var.build_type
  }
}