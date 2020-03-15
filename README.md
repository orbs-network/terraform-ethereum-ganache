# terraform-ethereum-ganache
Terraform project for setting up a remote Ganache atop AWS

This README assumes you have practical knowledge of how to install Terraform on your developer machine. you will of course also need AWS credentials to be able to run this project setup on your terminal.

*Do note* that this Terraform project assumes credentials as being set as an AWS profile and not as plain AWS keys variables. For more information on that (click here)[https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html]

There a few key variables required to run this project:

* AWS region - the `region` variable
* AWS credentials profile name - the `aws_profile` variable
* Instance type/size - the `instance_type` variable
* Path to public key to be used - the `ssh_keypath` variable

Basically all of these variables have their appropriate defaults based on the best practices available on the web.

## How to run this project

Firstly clone this project into your local machine by typing the following into your terminal:

```
git clone git@github.com:orbs-network/terraform-ethereum-ganache.git
```

After the repository finished downloading, go inside it's folder and type:

```
terraform init
```

Terraform will initialize the repository, downloading any plugins used as well (in our case mostly the AWS plugin)

Next up is peforming either a `plan` or an `apply` commands whether depending on your plan of action. To simply go ahead and create the machine in AWS simply issue an apply like so:

```
terraform apply -var aws_profile=staging -var region=eu-east-2 -auto-approve
```

(The variables are of course an example just to showcase how you can change the default variables inline while running the `apply` command)

Once done, Terraform will output the DNS and IP of the machine which was created. Ganache should answer on *TCP* port *8545* after a couple of minutes.

Enjoy
