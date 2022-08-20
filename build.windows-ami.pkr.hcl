build {
  source "amazon-ebs.base" {
    name           = "windows"
    communicator   = "winrm"
    user_data_file = "./provisioning/Setup-WinRM.ps1"
    winrm_insecure = true
    winrm_timeout  = "20m"
    winrm_use_ssl  = true
    winrm_username = local.windows_winrm_user[var.image_type]
  }

  ## Why repeating? https://github.com/rgl/packer-plugin-windows-update/issues/90#issuecomment-842569865
  # Note that restarts are only done when required by windows updates
  provisioner "windows-update" { pause_before = "1m" }
  provisioner "windows-update" { pause_before = "1m" }
  provisioner "windows-update" { pause_before = "1m" }

  provisioner "file" {
    pause_before = "1m"
    source       = "./provisioning/Add-SSHPubKey.ps1"
    destination  = "C:/"
  }

  provisioner "powershell" {
    environment_vars  = local.provisioning_env_vars
    elevated_user     = local.windows_winrm_user[var.image_type]
    elevated_password = build.Password
    script            = "./provisioning/windows-provision.ps1"
  }

  # Recommended (and sometimes required) before running deprovisioning (sysprep or AWS scripts)
  # ref. https:#www.packer.io/docs/builders/azure/arm#windows
  provisioner "windows-restart" {
    max_retries = 3
  }
  provisioner "file" {
    source      = "./provisioning/EC2-LaunchConfig.json"
    destination = "C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Config\\LaunchConfig.json"
  }
  # This provisioner must be the last for AWS EBS builds, after reboots
  provisioner "powershell" {
    elevated_user     = local.windows_winrm_user[var.image_type]
    elevated_password = build.Password
    # Ref. https:#docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-windows-user-data.html#user-data-scripts-subsequent
    inline = [
      "if($env:AGENT_OS_VERSION = '2019') { C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\SendWindowsIsReady.ps1 -Schedule; C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\InitializeInstance.ps1 -Schedule; C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\SysprepInstance.ps1 -NoShutdown;};"
    ]
  }
}
