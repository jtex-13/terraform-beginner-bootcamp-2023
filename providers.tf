# Backend
#terraform {
# backend "remote" {
#   hostname     = "app.terraform.io"
#   organization = "jtex-cloud-learning"
#
#   workspaces {
#     prefix = "terra-house-01"
#   }
#}
#

# Terraform Cloud
#terraform {
#  cloud {
#    organization = "jtex-cloud-learning"
#
#    workspaces {
#      name = "terra-house-01"
#    }
#  }
#}

# Random Provider
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }    
  }
}

provider "random" {
  # Configuration options
}

provider "aws" {
  # Configuration options
}