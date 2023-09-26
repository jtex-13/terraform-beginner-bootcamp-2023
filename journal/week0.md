# Terraform Beginner Bootcamp 2023

  - [Semantic Versioning](#semantic-versioning)
  - [Installing Terraform CLI](#installing-terraform-cli)
    * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
    * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
    * [Using Bash Script](#using-bash-script)
      + [Shebang](#shebang)
      + [Execution Consideration](#execution-consideration)
  - [GitPod Lifecyle](#gitpod-lifecyle)
  - [Working Env Vars](#working-env-vars)
    * [Env Command](#env-command)
    * [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
    * [Printing Vars](#printing-vars)
    * [Scoping of Env Vars](#scoping-of-env-vars)
    * [Persistting Env Vars in Gitpod](#persistting-env-vars-in-gitpod)
  - [AWS CLI Installation](#aws-cli-installation)
  - [Terraform Basics](#terraform-basics)
    * [Terraform Registry](#terraform-registry)
    * [Terraform Console](#terraform-console)
      + [Terraform Init](#terraform-init)
      + [Terraform Plan](#terraform-plan)
      + [Terraform Apply](#terraform-apply)
      + [Terraform Destory](#terraform-destory)
      + [Terraform Lock Files](#terraform-lock-files)
      + [Terraform State Files](#terraform-state-files)
      + [Terraform Directory](#terraform-directory)
  - [S3 Bucket](#s3-bucket)
  - [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)


## Semantic Versioning ##

This project will be utilizing semantic versioning [semver.org](https://semver.org/) for tagging.

Given a version number **MAJOR.MINOR.PATCH**, increment the:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.


## Installing Terraform CLI ##

### Considerations with the Terraform CLI changes ###

The current Terraform CLI installation instructions have changed due to gpg keyring changes. Please refer the latest instructions from Terraform documentation if you wish to run it line by line command [terraform-install-cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

### Considerations for Linux Distribution ###

This project is built in againts Ubuntu. Please consider checking your running Linux distribuion and accordingly, to distribution needs.

Example:
```
$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.3 LTS
Release:        22.04
Codename:       jammy
```

### Using Bash Script ###
While fixing the Terraform CLI gpg deprecation issue, another option to consider to run the installation is via bash script. 

The bash script is located here [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod task file ([.gitpod.yml](.gitpod.yml))
- This allow us to debug and execute  Terraform CLI installation
- This will allow better portability for other projects that need to install Terraform CLI.

#### Shebang ####

A Shebang (prounced Sha-bang) tells the bash script what program that will interpret the script. e.g. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability of different OS distribution
- will search the user's PATH for bash executable


Ref: https//en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Consideration ####

When executng the bash script we can use the `./` shorthand notation to execute the bash script.

`e.g. ./bin/install_terraformcli`

If we are using a script in ``.gitpod.yml`` we need to point the script to a program to interpret it.

`e.g. source ./bin/install_terraformcli`

To make a script file executable we need to change the permission as below example.
e.g.
  ```bash
  chmod 700 ./bin/install_terraform_cli
  ```

## GitPod Lifecyle

**NOTE:** Before, Init, Command

We need to be careful when using the `init` because it will not re-run if we restart an existing workspace.

Ref: https://www.gitpod.io/docs/configure/workspace/tasks

## Working Env Vars ##

### Env Command ###

We can list out all environment variables (Env Vars) using the `env` command

We can filter specific env vars using grep e.g. `env | grep AWS_`

### Setting and Unsetting Env Vars ###

In the terminal we can set using `export HELLO=world`

In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command

```bash
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export e.g.

```bash
#!/usr/bin/env bash
HELLO='world'

echo $HELLO
```

### Printing Vars ###

We can print an env var using echo e.g. `echo HELLO`

### Scoping of Env Vars ###

When you open up nmew bash terminals in VSCode it will not be aware of env vars that you have set in another windows

If you want to env vars to persist across all future bash terminals that are open you need to set env vars in you bash profile. e.g. `.bash_profile`

### Persistting Env Vars in Gitpod ###

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```bash
gp env HELLO='world'
```

All future workspaces launced will set the env vars for all bash terminals opened in these workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

## AWS CLI Installation ##

AWS CLI is installed for the project via bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI ENV VARS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

To check if AWS credentials is configured correctly by running the following AWS CLI below command:

```bash
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like below sample:

```json
{
    "UserId": "BIDH6O8CVRU1P3ISA1L0E",
    "Account": "012345678901",
    "Arn": "arn:aws:iam::012345678901:user/terraform-beginner-bootcamp"
}
```

In order for the user AWS CLI, an AWS CLI credits needs to be generated from IAM User.

## Terraform Basics ##

### Terraform Registry ###

Terraform sources their providers and modules from the Terraform registry which located at [registry.terraform.io](https://registry.terraform.io)

- **Providers:** is an interface to APIs that will allow to create resources in terraform.
- **Modules:**  are a way to make large amount of terraforn code modular, portable and sharable.

### Terraform Console ###

- To view a list of all trraform commands by running `terraform`

#### Terraform Init ####

- To initialize a terraform project run `terraform init` to download the set of binaries for the terraform providers that will be used in this project.

#### Terraform Plan ####

- To generate out a changeset, about the state of our infrastructure and what will be changed. We can output this changeset i.e. "plan" to be passed to an apply, but often you can just ignore outputting.

  `terraform init`

#### Terraform Apply ####

- To excecute the plan and pass the changeset to be execute by terraform. Apply should prompt yes or no, but it can be set to auto flag e.g. `terraform apply -auto-approve`

  `terraform apply`

#### Terraform Destory ####

- This will destroy resources.

  `terraform destroy`

  **NOTE:** Be mindful of this command and always review the summary of action before you confirm "Y".

#### Terraform Lock Files ####

- The `.terraform.lock.hcl` contains the locked versioning for providers or modules that should be used with this project.

- The terraform lock file should be committed to your Version Control System (VCS) e.g. Github

#### Terraform State Files ####

- The `.terraform.tfstate` contain information about the current state of your infrastructure.

- This file **SHOULD NOT BE COMMITTED** to your VCS.

- The file can contain sensentive data.

- If you lose this file, you lose the state of your infrastructure.

- A `.terraform.lock.hcl` is the previous state file state.

#### Terraform Directory ####

- The `.terraform` directory contains binaries of terraform providers.

## S3 Bucket ##

- To avoid any further error or issue during the creation of S3 bucket mainly on the naming, always refer the [bucketnamingrules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html).

## Issues with Terraform Cloud Login and Gitpod Workspace ##

- When attempting to run `terraform login` initially, it didn't push through as it tries to find the generated token. Possibly, this does not work expected in Gitpod Vscode in the browser.

- As the workaround, to manually generate a token in the [Terrform cloud](https://app.terraform.io/app/settings/tokens?source=terraform-login.)

- Accordingly, create and open a file below.
```bash
nano /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

- Paste the below json file code inside the `credentials.tfrc.json`.
```bash
{
    "credentials": {
        "app.terraform.io": {
            "token": "ENTER-YOUR-TERRAFORM-CLOUD-GENERATED-TOKEN"
        }
    }
}
```

- The following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials) has been automated as a workaround. 
