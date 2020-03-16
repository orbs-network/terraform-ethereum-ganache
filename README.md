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

### Deploy

Firstly clone this project into your local machine by typing the following into your terminal:

```
git clone git@github.com:orbs-network/terraform-ethereum-ganache.git
```

After the repository finished downloading, go inside it's folder and type:

```
terraform init
```

Terraform will initialize the repository, downloading any plugins used as well (in our case mostly the AWS plugin)
The next step would be to import our existing Elastic IP to attach to this machine
(The allocation of the IP can happen via the `aws` cli tool or via the AWS Console and is outside the scope of this guide)

```
terraform import -var aws_profile=staging -var region=eu-west-1 aws_eip.eip_ganache 52.44.35.215
```

Next up is peforming either a `plan` or an `apply` commands whether depending on your plan of action. To simply go ahead and create the machine in AWS simply issue an apply like so:

```
terraform apply -var aws_profile=staging -var region=eu-west-1 -auto-approve
```

(The variables are of course an example just to showcase how you can change the default variables inline while running the `apply` command)

### Test

Once done, Terraform will output the DNS and IP of the machine which was created. Ganache should answer on *TCP* port *8545* after a couple of minutes.

Use Ethereum [JSON RPC](https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getblockbynumber) to communicate with the node, this CURL command for example will get the latest block:

```
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest", false],"id":1}' 52.44.35.215:8545
```

### Destroy

When you want to destroy the Ganache machine and it's related assets, type the following to detach the Elastic IP from the Terraform workspace:

```
terraform state rm aws_eip.eip_ganache
```

Next up you can go ahead and type the following to destroy the machine and it's related resources:

```
terraform destroy -var aws_profile=staging -var region=eu-west-1 -auto-approve
```

Enjoy
