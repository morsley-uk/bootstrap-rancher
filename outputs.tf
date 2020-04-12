#     ____        _               _       
#    / __ \      | |             | |      
#   | |  | |_   _| |_ _ __  _   _| |_ ___ 
#   | |  | | | | | __| '_ \| | | | __/ __|
#   | |__| | |_| | |_| |_) | |_| | |_\__ \
#    \____/ \__,_|\__| .__/ \__,_|\__|___/
#                    | |                  
#                    |_|                  

output "admin_password" {

  value = random_password.admin-password.result

}

output "access_key" {

  value = rancher2_bootstrap.admin.token

}

output "admin_url" {

  value = rancher2_bootstrap.admin.url

}