#    ____              _       _                     _____                  _
#   |  _ \            | |     | |                   |  __ \                | |
#   | |_) | ___   ___ | |_ ___| |_ _ __ __ _ _ __   | |__) |__ _ _ __   ___| |__   ___ _ __
#   |  _ < / _ \ / _ \| __/ __| __| '__/ _` | '_ \  |  _  // _` | '_ \ / __| '_ \ / _ \ '__|
#   | |_) | (_) | (_) | |_\__ \ |_| | | (_| | |_) | | | \ \ (_| | | | | (__| | | |  __/ |
#   |____/ \___/ \___/ \__|___/\__|_|  \__,_| .__/  |_|  \_\__,_|_| |_|\___|_| |_|\___|_|
#                                           | |
#                                           |_|                                             

provider "rancher2" {
  
  alias = "bootstrap"
  
  api_url   = "rancher.morsley.io"
  bootstrap = true
  
}

resource "random_password" "admin-password" {
  
  length = 25

  lower = true
  min_lower = 5
  upper = true
  min_upper = 5
  number = true
  min_numeric = 5
  special = true
  min_special = 3
  
}

resource "rancher2_bootstrap" "admin" {
  
  provider = "rancher2.bootstrap"
  
  password = random_password.admin-password
  telemetry = true
  
}

output "admin_password" {
  
  value = random_password.admin-password
  
}