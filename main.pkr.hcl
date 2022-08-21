packer {
  required_version = ">= 1.7.2"
  required_plugins {
    amazon = {
      version = "1.1.2"
      source  = "github.com/hashicorp/amazon"
    }
    windows-update = {
      version = "0.14.1"
      source  = "github.com/rgl/windows-update"
    }
  }
}

build {
  sources = [
    "source.amazon-ebs.windows"
  ]

  provisioner "powershell" {
    # elevated_user     = local.winrm_username
    # elevated_password = local.winrm_password
    script            = "${path.root}/scripts/Instal-Chocolatey.ps1"
  }

    provisioner "powershell" {
    # elevated_user     = local.winrm_username
    # elevated_password = local.winrm_password
    script            = "${path.root}/scripts/Install-ChocolateyPackages.ps1"
  }

  post-processor "manifest" {
  }
}
