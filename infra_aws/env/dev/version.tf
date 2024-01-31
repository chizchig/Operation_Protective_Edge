# terraform {
#   backend "remote" {
#     organization = ""
#     workspaces {
#       name = ""
#     }
#   }
#   required_providers {
#     aws = {
#         source = "hashicorp/aws"
#         version = "~> 5.34.0"
#     }

#     kubernetes = {
#         source = "hashicorp/kubernetes"
#         version = "~> 2.13"
#     }
#   }
# }