# Terraform Beginner Bootcamp 2023

## Semantic Versioning ##

This project will be utilizing semantic versioning [semver.org](https://semver.org/) for tagging.

Given a version number **MAJOR.MINOR.PATCH**, increment the:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.


## Installing Terraform CLI ##

The current Terraform CLI installation instructions have changed due to gpg keyring changes. Please refer the latest instructions from Terraform documentation if you wish to run it line by line command [here]. (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

**Note:** This project is built in againts Ubuntu. Please consider checking your running Linux distribuion and accordingly, to distribution needs.

Example:
```
$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.3 LTS
Release:        22.04
Codename:       jammy
```

## Using Bash Script (optional)
While fixing the Terraform CLI gpg deprecation issue, another option to consider to run the installation is via bash script. 

The bash script is located here [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod task file ([.gitpod.yml](.gitpod.yml))
- This allow us to debug and execute  Terraform CLI installation
- This will allow better portability for other projects that need to install Terraform CLI.

## Shebang ##

A Shebang (prounced Sha-bang) tells the bash script what program that will interpret the script. e.g. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability of different OS distribution
- will search the user's PATH for bash executable


Ref: https//en.wikipedia.org/wiki/Shebang_(Unix)

## Execution Consideration

When executng the bash script we can use the `./` shorthand notation to execute the bash script.

`e.g. ./bin/install_terraformcli`

If we are using a script in ``.gitpod.yml`` we need to point the script to a program to interpret it.

`e.g. source ./bin/install_terraformcli`

To make a script file executable we need to change the permission as below example.
e.g.
  ```bash
  chmod 700 ./bin/install_terraform_cli
  ```

## Github Lifecyle (Before, Init, Command)

We need to be careful when using the `init` because it will not re-run if we restart an existing workspace.

Ref: https://www.gitpod.io/docs/configure/workspace/tasks

## Working Env Vars ##

We can list out all environment variables (Env Vars) using the `env` command

We can filter specific env vars using grep e.g. `env | grep AWS_`

## Setting and Unsetting Env Vars ##

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

## Printing Vars ##

We can print an env var using echo e.g. `echo HELLO`

## Scoping of Env Vars ##

When you open up nmew bash terminals in VSCode it will not be aware of env vars that you have set in another windows

If you want to env vars to persist across all future bash terminals that are open you need to set env vars in you bash profile. e.g. `.bash_profile`

## Persistting Env Vars in Gitpod ##

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