locals {
  ethereum_user_data = <<TFEOF
#! /bin/bash

# Remove old instances of Docker which might ship with ubuntu
apt-get remove docker docker-engine docker.io

apt-get update
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# Complete fingerprint: 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
apt-key fingerprint 0EBFCD88

add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

apt-get update
apt-get install -y docker-ce

docker run -d --name ganache -p "8545:8545" trufflesuite/ganache-cli -a 25 -m 'vanish junk genuine web seminar cook absurd royal ability series taste method identify elevator liquid' -i 5777 -p 8545

TFEOF
}

resource "aws_instance" "ethereum" {
  ami           = "${data.aws_ami.ubuntu-18_04.id}"
  count         = 1
  instance_type = "${var.instance_type}"

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
  }

  security_groups = ["${aws_security_group.ethereum.id}"]

  key_name  = "${aws_key_pair.deployer.key_name}"
  subnet_id = "${module.vpc.first-subnet-id}"

  user_data = "${local.ethereum_user_data}"

  tags = {
    Name = "${var.application}"
  }
}
