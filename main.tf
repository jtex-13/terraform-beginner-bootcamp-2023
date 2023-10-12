terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }

  cloud {
    organization = "jtex-cloud-learning"
    workspaces {
      name = "terra-house-01"
    }
  }
}  

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "family_coding_event" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.family_event.public_path
  content_version = var.family_event.content_version
}

resource "terratowns_home" "home" {
  name = "Family of Coders in 2023!"
  description = <<DESCRIPTION
Family Game Coders is a retreat conducted that allows their family members to learn how to code while playing games.
Also an oppurtunity for the coder parents to spend time and share their hidden talents to their kids.
DESCRIPTION
  domain_name = module.family_coding_event.domain_name
  town = "gamers-grotto"
  content_version = var.family_event.content_version
}

module "meal_coding_event" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.meal_event.public_path
  content_version = var.meal_event.content_version
}

resource "terratowns_home" "home_meal" {
  name = "It's Meal Time!"
  description = <<DESCRIPTION
The event will not be fun without the favorite foods.
So, to make it more enjoyable we ordered a boodle fight menu for everyone.
DESCRIPTION
  domain_name = module.meal_coding_event.domain_name
  town = "cooker-cove"
  content_version = var.meal_event.content_version
}

#module "terrahouse_aws" {
#  source              = "./modules/terrahouse_aws"
#  user_uuid           = var.user_uuid
#  bucket_name         = var.bucket_name
#  index_html_filepath = var.index_html_filepath
#  error_html_filepath = var.error_html_filepath
#  content_version     = var.content_version
#  assets_path         = var.assets_path
#}