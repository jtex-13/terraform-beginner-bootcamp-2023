# Terraform Beginner Bootcamp 2023 - Week 1 #

## Root Module Structure ##

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # Everything else.
├── variables.tf            # Stores the structure of input variables.
├── terraform.tfvars        # The data of variables we want to load into our terraform project.
├── providers.tf            # Defined required providers and their configuration.
├── outputs.tf              # Stores our outputs.
└── README.md               # Required for root modules.
```
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables ##

### Terraform Cloud Variables ###

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables ###

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag ###
- We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag ###

- Another way to set or pass a variables, is specifying their values in a variables definitions file (with a filename ending extension as .tfvars). For more about the this, please refer in this [link](https://developer.hashicorp.com/terraform/language/values/variables#variable-definitions-tfvars-files).

Example:
```bash
terraform apply -var-file="testing.tfvars"
```

### terraform.tvfars ###

- This is the default file to load in terraform variables in blunk

### auto.tfvars ###

- A way to auto load input variables is by having an `.auto.tfvars` extension. So basically, whatever the file name in variables inside these files will be auto loaded during terraform plan or apply execution.

### order of terraform variables ###

- The terraform variables loads in the following order as shown below. To know more about the please refer this [link](https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence).

    * Environment variables
    * The terraform.tfvars file, if present.
    * The terraform.tfvars.json file, if present.
    * Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
    * Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)

## Dealing With Configuration Drift ##

## What happens if we lose our state file? ##

- If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

- You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import ###

```bash
terraform import aws_s3_bucket.bucket bucket-name
```

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration ###

- If someone goes and delete or modifies cloud resource manually through ClickOps. 

- If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift.

## Fix using Terraform Refresh ##

```bash
terraform apply -refresh-only -auto-approve
```

## Terraform Modules ##

### Terraform Module Structure ###

- It is recommend to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables ###

- We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources ###

Using the source we can import the module from various places e.g.:
- Locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)