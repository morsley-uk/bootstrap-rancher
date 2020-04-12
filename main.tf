#    ____              _       _                     _____                  _
#   |  _ \            | |     | |                   |  __ \                | |
#   | |_) | ___   ___ | |_ ___| |_ _ __ __ _ _ __   | |__) |__ _ _ __   ___| |__   ___ _ __
#   |  _ < / _ \ / _ \| __/ __| __| '__/ _` | '_ \  |  _  // _` | '_ \ / __| '_ \ / _ \ '__|
#   | |_) | (_) | (_) | |_\__ \ |_| | | (_| | |_) | | | \ \ (_| | | | | (__| | | |  __/ |
#   |____/ \___/ \___/ \__|___/\__|_|  \__,_| .__/  |_|  \_\__,_|_| |_|\___|_| |_|\___|_|
#                                           | |
#                                           |_|                                             

# Take a newly installed Rancher and booststrap it...

# https://www.terraform.io/docs/providers/rancher2/index.html

provider "rancher2" {

  alias = "bootstrap"

  api_url   = "https://${var.subdomain}.${var.domain}"
  bootstrap = true

  insecure = true # This can be romoved when Let's Encrypt is fully working
  
}

# https://www.terraform.io/docs/providers/random/r/password.html

resource "random_password" "admin-password" {

  length = 25

  lower       = true
  min_lower   = 5
  upper       = true
  min_upper   = 5
  number      = true
  min_numeric = 5
  special     = true
  min_special = 3

}

# https://www.terraform.io/docs/providers/aws/r/s3_bucket.html

resource "aws_s3_bucket_object" "admin-password-txt" {

  bucket       = local.bucket_name
  key          = "/${var.name}/admin_password.txt"
  content      = random_password.admin-password.result
  content_type = "text/*"

}

# https://www.terraform.io/docs/providers/rancher2/r/bootstrap.html

resource "rancher2_bootstrap" "admin" {

  provider = rancher2.bootstrap

  password  = random_password.admin-password.result
  telemetry = true

}

resource "aws_s3_bucket_object" "admin-token" {

  bucket       = local.bucket_name
  key          = "/${var.name}/admin_token.txt"
  content      = rancher2_bootstrap.admin.token
  content_type = "text/*"

}