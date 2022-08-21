locals {
  os_type         = "windows"
  os_version      = "2022"
  image_name      = "packer-pyautomation-${local.os_type}-${local.os_version}"
  manifest_path   = "${path.cwd}/manifests/"
  manifest_output = "${local.manifest_path}${local.image_name}.json"
  winrm_username  = "Administrator"
  winrm_password  = "SuperS3cr3t!!!!"
}