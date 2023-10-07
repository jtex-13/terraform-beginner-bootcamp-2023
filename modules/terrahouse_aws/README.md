## Terrahome AWS ##

```tf
module "meal_coding_event" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.meal_event.public_path
  content_version = var.meal_event.content_version
}
```

THe public directory expects the following:
- index.html
- error.html
- assets

ALl top level files in assets will be copied, but not any subdirectories.