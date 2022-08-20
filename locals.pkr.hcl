locals {
  now_unix_timestamp    = formatdate("YYYYMMDDhhmmss", timestamp())
  agent                 = format("%s-%s", var.agent_os_type, var.agent_os_version)
  agent_os_version_safe = replace(var.agent_os_version, ".", "_")
  image_name            = format("pyautomation-%s-%s", var.agent_os_type, var.agent_os_version)
  provisioning_env_vars = concat(
    [for key, value in yamldecode(file(var.provision_env_file)) : "${upper(key)}=${value}"],
    [
      "CLOUD_TYPE=${var.image_type}",
      "ARCHITECTURE=${var.architecture}",
      "AGENT_OS_TYPE=${var.agent_os_type}",
      "AGENT_OS_VERSION=${var.agent_os_version}",
    ],
  )
}
