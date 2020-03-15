# Backend configuration is loaded early so we can't use variables
# Fill this in case you want to activate state storage for your Terraform project
# and save it as 'backend.tf'

# terraform {
#   backend "s3" {
#     region  = "<put-aws-region-here>"
#     bucket  = "<put-aws-bucket-name-here>"
#     key     = "state.tfstate"
#     encrypt = true                   #AES-256 encryption
#   }
# }
