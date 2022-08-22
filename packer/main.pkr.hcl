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

  ## Why repeating? https://github.com/rgl/packer-plugin-windows-update/issues/90#issuecomment-842569865
  # Note that restarts are only done when required by windows updates
  provisioner "windows-update" { pause_before = "1m" }
  provisioner "windows-update" { pause_before = "1m" }
  provisioner "windows-update" { pause_before = "1m" }

  provisioner "powershell" {
    script = "${path.root}/scripts/Install-Chocolatey.ps1"
  }

  provisioner "powershell" {
    script = "${path.root}/scripts/Install-ChocolateyPackages.ps1"
  }

  provisioner "powershell" {
    script = "${path.root}/scripts/EC2-Sysprep.ps1"
  }

  post-processor "manifest" {
  }
}
